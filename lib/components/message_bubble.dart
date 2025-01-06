import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final CrossAxisAlignment alignment;
  final bool mssgFromCurrentSender;
  final DocumentSnapshot doc;
  final bool firstMessage;
  final String userEmail;
  MessageBubble(
      {super.key,
      required this.alignment,
      required this.doc,
      required this.firstMessage,
      required this.mssgFromCurrentSender,
      required this.userEmail});

  ChatService chatservice = ChatService();

  ///void show modal from bottom
  Future<void> showBottomModal(context, String userEmail) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ///report message
                ListTile(
                  leading: const Icon(Icons.flag),
                  title: const Text('Report'),
                  onTap: () {
                    Navigator.pop(context);
                    _reportMessage(context);
                  },
                ),

                //block user
                ListTile(
                  leading: const Icon(Icons.block),
                  title: const Text('Block user'),
                  onTap: () {
                    Navigator.pop(context);
                    _blockUser(context);
                  },
                ),

                //cancel button

                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text('Cancel'),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
          );
        });
  }

  // report message
  void _reportMessage(context) {
    showDialogOnLogout(context, content: 'Report  "${doc['message']}" ?',
        onPressCallBack: () async {
      await chatservice.reportMessage(
          message: doc['message'], userEmail: userEmail);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Message Reported!')));
    }, title: 'Report?', buttonText: 'Report');
  }

  //block user

  void _blockUser(context) async {
     showDialogOnLogout(context,
        content: 'Are you sure you want to block user?',
        onPressCallBack: () async {
      await chatservice.blockUser(userEmail: userEmail);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User blocked!')));
    }, title: 'Block!', buttonText: 'Block');
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        GestureDetector(
          onLongPress: () {
            if (!mssgFromCurrentSender) {
              showBottomModal(context, userEmail);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 25.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: mssgFromCurrentSender
                  ? const Color(0xff3B82F6)
                  : Theme.of(context).colorScheme.tertiary,
              borderRadius: mssgFromCurrentSender
                  ? firstMessage
                      ? const BorderRadiusDirectional.only(
                          topStart: Radius.circular(15.0),
                          bottomStart: Radius.circular(15.0),
                          bottomEnd: Radius.circular(15.0),
                        )
                      : BorderRadius.circular(15.0)
                  : firstMessage
                      ? const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(15.0),
                          bottomStart: Radius.circular(15.0),
                          bottomEnd: Radius.circular(15.0),
                        )
                      : BorderRadius.circular(15.0),
            ),
            child: Text(
              doc['message'],
              style: kChatTextStyle,
            ),
          ),
        )
      ],
    );
  }
}
