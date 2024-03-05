import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class ThemeProvider with ChangeNotifier {
  SharedPreferences prefs;
  ThemeProvider({required this.prefs});

  String getCurrentThemeMode() {
    return prefs.getString("theme")!;
  }

  void changeSelectedTheme(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", value);
    notifyListeners();
  }
}
