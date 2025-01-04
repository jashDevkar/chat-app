import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: const Color(0xff121417), // A darker surface color for dark mode.
      secondary: Colors.white,
      primary: Colors.transparent,
      tertiary: const Color(0xff6B7280),
      inversePrimary: Colors.grey.shade200,
    ),
    cardColor: const Color(0xff6B7280),
    primaryColor: const Color(0xff3B82F6));


// const Color(0xff3B82F6)



///surface = background of scaffold
///primary = nav bar color
///secondary = navbaar text
///tertiary = reciecer background text color
///card color card color
///inverse primary for card text
///const Color(0xff63A7F8)