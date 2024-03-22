import 'package:flutter/material.dart';

class AppImageProvider with ChangeNotifier {
  String? _imagePath;
  String? _imageName;

  String? _idImagePath;
  String? _idImageName;

  void setImagePathAndName(String? path, String? name) {
    _imagePath = path;
    _imageName = name;
    notifyListeners();
  }

// sperate image provider for id image
  void setIdImagePathAndName(String? path, String? name) {
    _idImagePath = path;
    _idImageName = name;
    notifyListeners();
  }

  String? get imagePath => _imagePath;
  String? get imageName => _imageName;
  String? get idImagePath => _idImagePath;
  String? get idImageName => _idImageName;
}
