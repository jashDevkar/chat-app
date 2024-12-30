import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void logout() async {
    await _authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 20,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ///will display user current email
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(_authService.currentUserEmail),
                ],
              ),
            ),

            ///home navigator
            ListTile(
              leading: const Icon(Icons.home),
              title: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text('Home'),
              ),
            ),

            ///settings navigator
            ListTile(
              leading: const Icon(Icons.settings),
              title: GestureDetector(
                onTap: () {},
                child: const Text('Settings'),
              ),
            ),

            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),

            ///logout button
            ListTile(
              leading: const Icon(Icons.logout),
              title: GestureDetector(
                onTap: logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
      body: userStream(context),
    );
  }

  Widget userStream(BuildContext context) {
    return StreamBuilder(
        stream: _chatService.getUsers(),
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

          return ListView(
            children: data!.map((user) {
              if (user['email'] != _authService.currentUserEmail) {
                return UserTile(
                    data: user,
                    onTapCallBack: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ChatPage()),
                      );
                    });
              } else {
                return Container();
              }
            }).toList(),
          );
        });
  }
}
