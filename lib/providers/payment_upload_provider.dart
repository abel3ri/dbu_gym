import 'package:flutter/material.dart';

class PaymentUploadProvider with ChangeNotifier {
  int _activeIndex = 0;

  void setIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  int get activeIndex => _activeIndex;
}
