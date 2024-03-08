import 'package:flutter/material.dart';

class ProfileImageProvider with ChangeNotifier {
  String? _imagePath;
  String? _imageName;
  void setImagePathAndName(String? path, String? name) {
    _imagePath = path;
    _imageName = name;
    notifyListeners();
  }

  String? get imagePath => _imagePath;
  String? get imageName => _imageName;
}
