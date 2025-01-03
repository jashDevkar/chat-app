import 'package:chat_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final CrossAxisAlignment alignment;
  final bool mssgFromCurrentSender;
  final DocumentSnapshot doc;
  final bool firstMessage;
  const MessageBubble(
      {super.key,
      required this.alignment,
      required this.doc,
      required this.firstMessage,
      required this.mssgFromCurrentSender});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0),
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: mssgFromCurrentSender
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            borderRadius: mssgFromCurrentSender
                ? firstMessage
                    ? const BorderRadiusDirectional.only(
                        topStart: Radius.circular(30.0),
                        bottomStart: Radius.circular(30.0),
                        bottomEnd: Radius.circular(30.0),
                      )
                    : BorderRadius.circular(30.0)
                : firstMessage
                    ? const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(30.0),
                        bottomStart: Radius.circular(30.0),
                        bottomEnd: Radius.circular(30.0),
                      )
                    : BorderRadius.circular(30.0),
          ),
          child: Text(
            doc['message'],
            style: kChatTextStyle,
          ),
        )
      ],
    );
  }
}
