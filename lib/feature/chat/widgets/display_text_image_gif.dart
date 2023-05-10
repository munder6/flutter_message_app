import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:messagesapp/common/enums/message_enum.dart';
import 'package:messagesapp/feature/chat/widgets/video_player_item.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(message));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                );
              })
            : type == MessageEnum.video
                ? VideoPlayerItem(
                    videoUrl: message,
                  )
                : type == MessageEnum.gif
                    ? ClipRRect(
                      //borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                          imageUrl: message,
                        ),
                    )
                    : ClipRRect(
                     // borderRadius: BorderRadius.circular(30),
                       borderRadius: const BorderRadius.only(
                       topLeft: Radius.circular(10),
                       topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                         bottomRight: Radius.circular(10),
      ),
                      child: CachedNetworkImage(
                          imageUrl: message,
                        ),
                    );
  }
}
