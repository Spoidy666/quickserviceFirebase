import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickservice/Theme/theme.dart';

class Themecubit extends Cubit<ThemeData> {
  Themecubit() : super(lightmode) {
    _loadTheme();
  }

  Future<void> enableDarkMode() async {
    emit(darkmode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isDarkMode', 1);
  }

  Future<void> enableLightMode() async {
    emit(lightmode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isDarkMode', 0);
  }

  Future<void> enableColorMode() async {
    emit(colormode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isColorMode', 2);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getInt('isDarkMode') ?? 0;
    switch (isDark) {
      case 1:
        emit(darkmode);
        break;
      case 2:
        emit(colormode);
        break;
      case 0:
      default:
        emit(lightmode);
        break;
    }
  }
}
