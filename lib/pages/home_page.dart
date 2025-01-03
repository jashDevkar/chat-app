import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  void logout(context) async {
    ///show dialog box before loging out
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.error),
          iconColor: Colors.red,
          title: const Text('Hey User!'),
          content: const Text(
            'Are you sure you want to log out?',
            textAlign: TextAlign.center,
          ),
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _authService.logout();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              child: const Text(
                'Logout',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        }),
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
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

            ///logout button
            ListTile(
              leading: const Icon(Icons.logout),
              title: GestureDetector(
                onTap: () => logout(context),
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
            padding: const EdgeInsets.only(top: 10.0),
            children: data!.map((user) {
              if (user['email'] != _authService.currentUserEmail) {
                return UserTile(
                  data: user,
                  onTapCallBack: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: ChatPage(
                          recieverId: user['uid'],
                          recieverEmail: user['email'],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            }).toList(),
          );
        });
  }
}
