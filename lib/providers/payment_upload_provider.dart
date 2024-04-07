import 'package:flutter/material.dart';

class PaymentUploadProvider with ChangeNotifier {
  /// index for payment upload page slider
  int _activeIndex = 0;
  bool isLoading = false;

  void setIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  /// show CPI once the user taps upload receipt btn
  void toggleIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  int get activeIndex => _activeIndex;
}
