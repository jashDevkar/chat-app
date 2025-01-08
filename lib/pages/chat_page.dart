import 'package:chat_app/components/chat_input_field.dart';
import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/message_stream.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverId;
  final String recieverEmail;
  ChatPage({super.key, required this.recieverId, required this.recieverEmail});

  final TextEditingController chatController = TextEditingController();

  final ChatService _chatService = ChatService();

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
                      title: 'Delete!',
                      scaffoldMessage: 'All messages deleted!',
                      content: 'Delete all chat?',
                      buttonText: 'Delete',
                      onPressCallBack: () async {
                        ChatService chatService = ChatService();
                        await chatService.deleteAllChat(recieverId: recieverId);
                      },
                    ),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: MessageStream(
              recieverId: recieverId,
              recieverEmail: recieverEmail,
            )),
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
                      Icons.send_rounded,
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
}
