import 'package:flutter/material.dart';

class PaymentUploadProvider with ChangeNotifier {
  int _activeIndex = 0;
  bool isLoading = false;

  void setIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  void toggleIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  int get activeIndex => _activeIndex;
}
