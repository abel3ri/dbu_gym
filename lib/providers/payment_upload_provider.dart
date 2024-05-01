import 'package:flutter/material.dart';

class PaymentUploadProvider with ChangeNotifier {
  int _activeIndex = 0;
  bool _isLoading = false;
  TextEditingController _receiptController = TextEditingController();

  void setIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  void toggleIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  int get activeIndex => _activeIndex;
  bool get isLoading => _isLoading;
  TextEditingController get receiptController => _receiptController;
}
