import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  void register(context) async {
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await _authService.register(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } catch (e) {
        dialogBox(context, e.toString());
      }
    } else {
      dialogBox(context, 'password didnt matched');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4.0,
        title: Text(
          'Register',
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
              'Lets create an account!',
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
              height: 10.0,
            ),

            ///confirm password field
            MyTextfield(
              hintText: 'confirm your password',
              controller: confirmPasswordController,
              isObscure: true,
            ),

            const SizedBox(
              height: 20.0,
            ),

            ///login button
            MyButton(
              onTap: () => register(context),
              text: 'Register',
            ),

            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
