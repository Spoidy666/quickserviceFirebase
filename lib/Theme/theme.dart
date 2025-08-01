import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.white,
        primary: Colors.black,
        secondary: Colors.white,
        tertiary: Colors.grey.shade300));
ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.white,
      secondary: Colors.black,
      tertiary: Colors.black45,
    ));
ThemeData colormode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.orange,
        primary: Colors.black,
        secondary: Colors.red,
        tertiary: Colors.green));
