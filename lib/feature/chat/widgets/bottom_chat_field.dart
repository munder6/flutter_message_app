import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:messagesapp/common/utility/utils.dart';
import 'package:messagesapp/feature/chat/controller/chat_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:messagesapp/common/enums/message_enum.dart';
import 'package:messagesapp/common/providers/message_reply_provider.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
            widget.isGroupChat,
          );
      setState(() {
        _messageController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
          widget.isGroupChat,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }


  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Container(
          height: 45,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorRadius: const Radius.circular(30),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18,),
                  keyboardAppearance: Brightness.dark,
                  cursorColor: Colors.white,
                  focusNode: focusNode,
                  controller: _messageController,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.grey[900],
                    suffixIcon: IconButton(
                      onPressed: selectVideo,
                      icon: const Icon(
                        EvaIcons.videoOutline,
                        color: Colors.white,
                      ),
                    ),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 20,
                        child: IconButton(
                            onPressed: selectImage,
                               icon: const Icon( EvaIcons.cameraOutline, color: Colors.white,size: 24,),),
                      ),
                    ),
                    hintText: 'Type a message ...',
                    hintStyle: const TextStyle(color: Colors.white54, fontSize: 16, fontFamily: 'Default'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                  // right:2,
                  // left: 6,
                ),
                child: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(9,120,232, 1),
                  radius: 22,
                  child: GestureDetector(
                    onTap: sendTextMessage,
                    child:  Icon(
                      isShowSendButton
                          ? EvaIcons.paperPlane
                          : isRecording
                              ? EvaIcons.close
                              : EvaIcons.micOutline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
