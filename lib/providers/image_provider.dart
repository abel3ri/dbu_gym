import 'package:flutter/material.dart';

class ProfileImageProvider with ChangeNotifier {
  String? _imagePath;

  void setImagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }

  String? get imagePath => _imagePath;
}
