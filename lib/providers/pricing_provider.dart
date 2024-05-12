import 'package:flutter/material.dart';

class PricingProvider with ChangeNotifier {
  int _activeIndex = 0;
  bool _oneThreeDays = true;
  bool _fourSixDays = false;
  Map<String, dynamic>? _priceData;

  void changeActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  void toggleOneThreeDays(bool value) {
    _oneThreeDays = value;
    _fourSixDays = !value;
    notifyListeners();
  }

  void toggleFourSixDays(bool value) {
    _fourSixDays = value;
    _oneThreeDays = !value;
    notifyListeners();
  }

  void setPriceData(Map<String, dynamic> priceData) {
    _priceData = priceData;
    notifyListeners();
  }

  bool get oneThreeDays => _oneThreeDays;
  bool get fourSixDays => _fourSixDays;
  int get activeIndex => _activeIndex;
  Map<String, dynamic>? get priceData => _priceData;
}
