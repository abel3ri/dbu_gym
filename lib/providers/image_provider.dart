import 'package:flutter/material.dart';

class AppImageProvider with ChangeNotifier {
  String? _profileImagePath;
  String? _profileImageName;

  String? _idImagePath;
  String? _idImageName;

  String? _receiptImagePath;
  String? _receiptImageName;

  void setProfileImagePathAndName(String? path, String? name) {
    _profileImagePath = path;
    _profileImageName = name;
    notifyListeners();
  }

// sperate image provider for id image
  void setIdImagePathAndName(String? path, String? name) {
    _idImagePath = path;
    _idImageName = name;
    notifyListeners();
  }

  void setReceiptImagePathAndName(String? path, String? name) {
    _receiptImagePath = path;
    _receiptImageName = name;
    notifyListeners();
  }

  String? get profileImagePath => _profileImagePath;
  String? get profileImageName => _profileImageName;
  String? get idImagePath => _idImagePath;
  String? get idImageName => _idImageName;
  String? get receiptImagePath => _receiptImagePath;
  String? get receiptImageName => _receiptImageName;
}
