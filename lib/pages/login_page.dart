import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  void login(context) async {
    ///try login with email and password
    try {
      await _auth.login(
          email: emailController.text, password: passwordController.text);
    }

    ///catch error if any and show a snack bar...
    catch (e) {
      dialogBox(context,e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4.0,
        title: Text(
          'Login',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Icon(
                Icons.message,
                size: 70,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(
              height: 25.0,
            ),

            ///welcome back text
            const Text(
              'Welcome back!',
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 10.0,
            ),

            ///email text field
            MyTextfield(
              hintText: "Enter your email",
              controller: emailController,
              isObscure: false,
            ),

            const SizedBox(
              height: 10.0,
            ),

            ///password field
            MyTextfield(
              hintText: 'Enter your password',
              controller: passwordController,
              isObscure: true,
            ),

            const SizedBox(
              height: 20.0,
            ),

            ///login button
            MyButton(
              onTap: () => login(context),
              text: 'Login',
            ),

            const SizedBox(
              height: 20.0,
            ),

            ///register text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont\' have an account?'),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: RegisterPage()),
                  ),
                  child: const Text(
                    'Register now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
