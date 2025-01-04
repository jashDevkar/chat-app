import 'package:chat_app/components/error_dialog_box.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void login(context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await _authService.login(
            email: emailController.text, password: passwordController.text);
      } catch (e) {
        dialogBox(context, e.toString());
      }
    } else {
      dialogBox(context, 'All fields are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
                child: SizedBox(
              height: 130,
              child: Image.asset('assets/images/flash.png'),
            )),

            const SizedBox(
              height: 25.0,
            ),
            const Text(
              'Welcome back!',
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
                const Text('Don\'t have an account?'),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: RegisterPage(),
                    ),
                  ),
                  child: Text(
                    'Register now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.yellowAccent : null),
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
