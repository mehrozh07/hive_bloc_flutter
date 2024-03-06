import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeHelper {
  Future<bool> isDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_dark") ?? false;
  }

  Future<void> setTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_dark", !isDark);
  }
}

const TextTheme lightTextTheme = TextTheme(
  bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
  bodySmall: TextStyle(color: Colors.black, fontSize: 14),
  titleSmall:
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
  titleLarge:
      TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
);

const ListTileThemeData darkListTileThemeData = ListTileThemeData(
  tileColor: Colors.black54,
);

const InputDecorationTheme lightInputDecorationTheme =
    InputDecorationTheme(filled: true, fillColor: Colors.white);
const InputDecorationTheme darkInputDecorationTheme =
    InputDecorationTheme(filled: true, fillColor: Colors.black54);
const ListTileThemeData lightListTileThemeData = ListTileThemeData(
  tileColor: Colors.white,
);

const TextTheme darkTextTheme = TextTheme(
  bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
  bodySmall: TextStyle(color: Colors.white, fontSize: 14),
  titleSmall:
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  titleLarge:
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
);
