import 'package:chat_app/components/message_bubble.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*


message stream
this code is responsible for displaying messages

this code will listen to chat_rooms/user chat room/ messages collection

if there is update in message
this will update the message in message bulle in list view

*/

// ignore: must_be_immutable
class MessageStream extends StatelessWidget {
  final String recieverId;
  final String recieverEmail;

  MessageStream(
      {super.key, required this.recieverId, required this.recieverEmail});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  String? sender;
  bool firstMessage = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getMessages(recieverId: recieverId),
      builder: (context, snapshot) {
        ///check if it is waiting if yes than show loading screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        ///if firestore throws error than show error
        if (snapshot.hasError) {
          return const Text('Error');
        }

        ///else show all data if data is present
        final data = snapshot.data!.docs;
        sender = null;
        firstMessage = true;

        ///check if data is not empty
        if (data.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ListView(
              children: data.map<MessageBubble>(
                (DocumentSnapshot doc) {
                  final mssgFromCurrentSender =
                      doc['senderEmail'] == _authService.currentUserEmail
                          ? true
                          : false;
                  if (sender == null) {
                    sender = doc['senderEmail'];
                    firstMessage = true;
                  } else if (sender == doc['senderEmail']) {
                    firstMessage = false;
                  } else {
                    sender = doc['senderEmail'];
                    firstMessage = true;
                  }
                  final CrossAxisAlignment alignment = mssgFromCurrentSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start;

                  return MessageBubble(
                    alignment: alignment,
                    doc: doc,
                    userEmail: recieverEmail,
                    firstMessage: firstMessage,
                    mssgFromCurrentSender: mssgFromCurrentSender,
                  );
                },
              ).toList(),
            ),
          );
        }

        return const Center(
          child: Text('Chat here'),
        );
      },
    );
  }
}
