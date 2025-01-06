import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlockedUserPage extends StatelessWidget {
  BlockedUserPage({super.key});

  ChatService _chatService = ChatService();
  AuthService _authService = AuthService();

  void _showDialogToUnblock(context, {required String userEmail}) {
    showDialogOnLogout(context, content: 'Unblock $userEmail ?',
        onPressCallBack: () async {
      _chatService.unBlockUser(userEmail: userEmail);
    }, title: 'Unblock', buttonText: 'Unblock');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blocked Users',
        ),
        centerTitle: true,
      ),
      body: userStream(context),
    );
  }

  Widget userStream(BuildContext context) {
    return StreamBuilder(
        stream: _chatService.getBlockedUserStream(
            userId: _authService.currentUserEmail),
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data!.isEmpty) {
            return const Center(
              child: Text('No blocked users'),
            );
          }

          return ListView(
            padding: const EdgeInsets.only(top: 10.0),
            children: data!.map((user) {
              return UserTile(
                data: user,
                onTapCallBack: () {
                  _showDialogToUnblock(context, userEmail: user['email']);
                },
              );
            }).toList(),
          );
        });
  }
}
