import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  String _selectedTheme = 'system';

  void changeSelectedTheme(String value) {
    _selectedTheme = value;
    notifyListeners();
  }

  String get selectedTheme => _selectedTheme;
}
