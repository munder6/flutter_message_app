import 'package:flutter/material.dart';
import 'package:messagesapp/common/utility/colors.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:messagesapp/common/enums/message_enum.dart';
import 'package:messagesapp/feature/chat/widgets/display_text_image_gif.dart';


class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.isSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
              const  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(10),
                    )),
           // color: const Color.fromRGBO(9,120,232, 1),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[400]!,
                    Colors.blue[800]!,
                   // Colors.blue[300]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: type == MessageEnum.text
                        ? const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 12,
                            bottom: 6,
                          )
                        : const EdgeInsets.only(
                            left: 12,
                            top: 12,
                            right: 12,
                            bottom: 6,
                          ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (isReplying) ...[
                          Text(
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white

                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: DisplayTextImageGIF(
                              message: repliedText,
                              type: repliedMessageType,
                            ),
                          ),
                         // const SizedBox(height: 8),
                        ],
                        DisplayTextImageGIF(
                          message: message,
                          type: type,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              isSeen ? Icons.done_all : Icons.done,
                              size: 18,
                              color: isSeen ? Colors.white : Colors.white60,
                            ),
                            SizedBox(width: 2),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  // Positioned(
                  //   bottom: 4,
                  //   right: 10,
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         date,
                  //         style: const TextStyle(
                  //           fontSize: 13,
                  //           color: Colors.white60,
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         width: 5,
                  //       ),
                  //       Icon(
                  //         isSeen ? EvaIcons.doneAllOutline : EvaIcons.checkmark,
                  //         size: 20,
                  //         color: isSeen ? Colors.blue : Colors.white60,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
