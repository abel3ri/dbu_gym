import 'package:flutter/material.dart';

class PaymentUploadProvider with ChangeNotifier {
  /// index for payment upload page slider
  int _activeIndex = 0;
  bool _isLoading = false;
  TextEditingController _receiptController = TextEditingController();

  void setIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

<<<<<<< HEAD
  void toggleIsLoading() {
    _isLoading = !_isLoading;
=======
  /// show CPI once the user taps upload receipt btn
  void toggleIsLoading(bool value) {
    isLoading = value;
>>>>>>> fe93576f329f4f3aa950b83f34fe6a48c11bf242
    notifyListeners();
  }

  int get activeIndex => _activeIndex;
  bool get isLoading => _isLoading;
  TextEditingController get receiptController => _receiptController;
}
