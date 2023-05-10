import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messagesapp/common/utility/circularloader.dart';
import 'package:messagesapp/feature/auth/controller/auth_controller.dart';
import 'package:messagesapp/feature/call/screens/call_pickup_screen.dart';
import 'package:messagesapp/feature/chat/widgets/bottom_chat_field.dart';
import 'package:messagesapp/feature/chat/widgets/chat_list.dart';
import 'package:messagesapp/models/user_model.dart';


class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.00,
          elevation: 0,
          backgroundColor: Colors.black,
          title: isGroupChat
              ? Text(name)
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 35,
                          height: 40,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(profilePic),
                                ),
                              ),
                               Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: snapshot.data!.isOnline ? Colors.green : Colors.transparent,
                                  radius: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: const TextStyle(fontFamily: 'Default', fontSize: 16),),
                            Text(snapshot.data!.isOnline ? "Online" : "Offline", style: const TextStyle(fontFamily: 'Default', fontSize: 10),),
                          ],
                        ),
                      ],
                    );
                  }),
          actions: [
             IconButton(
              onPressed: () {},
              icon: const Icon(EvaIcons.videoOutline, size: 26,),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(EvaIcons.phoneCallOutline, size: 26,),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.grey[900],
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context){
                      return SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(profilePic),
                            ),
                            const SizedBox(height: 20),
                            Text(name, style: const TextStyle(color: Colors.white, fontSize: 22),),
                            Text("User ID : $uid", style: const TextStyle(color: Colors.white, fontSize: 15),),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(EvaIcons.videoOutline, size: 30,color: Colors.white,),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(EvaIcons.phoneCallOutline, size: 30,color: Colors.white,),
                                ),
                              ],
                            )

                          ],
                        ),
                      );
                    }
                );
              } ,
              icon: const Icon(EvaIcons.infoOutline, size: 26,),
            ),

          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: ChatList(
                  recieverUserId: uid,
                  isGroupChat: isGroupChat,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BottomChatField(
                  recieverUserId: uid,
                  isGroupChat: isGroupChat,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


