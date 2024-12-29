import 'package:chat_app/auth_gate/auth_gate.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}