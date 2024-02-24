import 'package:flutter/foundation.dart';

class HomePageGridProvider with ChangeNotifier {
  String _selectedCategory = "muscle";
  void changeCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;
}
