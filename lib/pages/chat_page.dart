import 'package:chat_app/components/chat_input_field.dart';
import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/message_bubble.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverId;
  final String recieverEmail;
  ChatPage({super.key, required this.recieverId, required this.recieverEmail});

  final TextEditingController chatController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  String? sender;

  bool firstMessage = true;

  void sendMessage() async {
    if (chatController.text.isNotEmpty) {
      await _chatService.sendMessage(
          recieverId: recieverId, text: chatController.text);
      chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            recieverEmail,
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.secondary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => showDialogOnLogout(
                      context,
                      content: 'Delete all chat?',
                      buttonText: 'Delete',
                      onPressCallBack: () async {
                        sender = null;
                        ChatService chatService = ChatService();
                        await chatService.deleteAllChat(recieverId: recieverId);
                      },
                    ),
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Column(
          children: [
            Expanded(child: messageStream(context)),
            Padding(
              padding:
                  const EdgeInsets.only(right: 10.0, left: 5.0, bottom: 10.0),
              child: Row(
                children: [
                  ChatInputField(
                    chatController: chatController,
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xff3B82F6),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    icon: const Icon(
                      Icons.upload,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///message stream
  ///this code is responsible for displaying messages

  Widget messageStream(BuildContext context) {
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
                  final CrossAxisAlignment alignment =
                      doc['senderEmail'] == mssgFromCurrentSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start;

                  return MessageBubble(
                    alignment: alignment,
                    doc: doc,
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
