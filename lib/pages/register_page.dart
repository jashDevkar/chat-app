import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/utils/constants.dart';
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
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        try {
          await _authService.register(
              email: emailController.text, password: passwordController.text);
          Navigator.pop(context);
        } catch (e) {
          dialogBox(context, e.toString());
        }
      } else {
        dialogBox(context, 'All fields are required');
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
                child: SizedBox(
              height: 130,
              child: Image.asset(
                'assets/images/flash.png',
              ),
            )),

            const SizedBox(
              height: 25.0,
            ),

            ///welcome back text
            const Text(
              'Lets create an account!',
              textAlign: TextAlign.center,
              style: kGreetingsStyle,
            ),

            const SizedBox(
              height: 15.0,
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
