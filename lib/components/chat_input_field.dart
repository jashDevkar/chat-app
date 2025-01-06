import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatInputField extends StatelessWidget {
  final TextEditingController chatController;
  FocusNode? focusNode;
  ChatInputField({super.key, required this.chatController, this.focusNode});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 120),
        child: Container(
          padding: const EdgeInsets.only(
              right: 20.0, top: 5.0, left: 20.0, bottom: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: TextField(
              focusNode: focusNode,
              scrollController: _scrollController,
              keyboardType: TextInputType.multiline,
              controller: chatController,
              style: const TextStyle(color: Colors.white),
              maxLines: 5,
              minLines: 1,
              expands: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                fillColor: Theme.of(context).colorScheme.tertiary,
                filled: true,
                hintText: 'Send Message',
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
