import 'dart:math';

import 'package:flutter/material.dart';

class BMIProvider with ChangeNotifier {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  double calcBMI() {
    return (double.parse(_weightController.text)) /
        (pow(double.parse(_heightController.text), 2));
  }

  TextEditingController get weightController => _weightController;
  TextEditingController get heightController => _weightController;
}
