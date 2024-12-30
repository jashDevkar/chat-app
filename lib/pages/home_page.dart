import 'package:chat_app/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
 
  HomePage({super.key});

  final AuthService _authService = AuthService();

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
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Text(_authService.currentUserEmail),
      ),
    );
  }
}
