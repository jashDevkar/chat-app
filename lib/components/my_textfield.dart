import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  FocusNode? focusNode;
  final TextEditingController controller;
  MyTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.isObscure,this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextField(
        focusNode: focusNode,
        obscureText: isObscure,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3B82F6)),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff06B7280)),
        ),
      ),
    );
  }
}
