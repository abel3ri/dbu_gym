import 'package:flutter/material.dart';

class CarouselProvider with ChangeNotifier {
  int _currentCarouselItemIndex = 1;

  get currentCarouselItemIndex => _currentCarouselItemIndex;

  void changeItemIndex(int index) {
    _currentCarouselItemIndex = index;
    notifyListeners();
  }
}
