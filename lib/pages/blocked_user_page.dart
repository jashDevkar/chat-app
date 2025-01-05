import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class BlockedUserPage extends StatelessWidget {
  BlockedUserPage({super.key});

  ChatService _chatService = ChatService();
  AuthService _authService = AuthService();

  void _showDialogToUnblock(context, {required String userEmail}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Unblock user?'),
              content: Text('Unblock $userEmail ?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _chatService.unBlockUser(userId: userEmail);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Color(0xff3B82F6),
                      ),
                    ),
                  ),
                  child: Text(
                    'Unblock',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ));
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
            return Center(
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
