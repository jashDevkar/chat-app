import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        ///check if connection is established
        ///if not show loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        ///checking if client is logged in or not
        final String? client =
            snapshot.hasData ? FirebaseAuth.instance.currentUser?.email : null;

        ///if client is not logged in than client value will be null
        ///and the user will be redirected to login page
        ///else user will be redirected to home page
        if (client != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
