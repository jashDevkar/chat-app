import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Chat me'),
        ),
        body: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text('Text area'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: MyTextfield(
                hintText: 'Enter text',
                controller: chatController,
                isObscure: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
