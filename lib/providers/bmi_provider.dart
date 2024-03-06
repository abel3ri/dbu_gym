import 'dart:math';

import 'package:flutter/material.dart';

class BMIProvider with ChangeNotifier {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _bmi = 0;

  void calcBMI() {
    _bmi = (double.parse(_weightController.text)) /
        (pow(double.parse(_heightController.text), 2));

    notifyListeners();
  }

  String bmiMessageMap(double bmi) {
    if (bmi > 22) {
      return "It seems you are over weight, you should take less calorie foods.";
    } else if (bmi < 18) {
      return "It seems you are under weight, you should take more calorie foods.";
    }
    return "You are in good shape. Keep doing what you're doing.";
  }

  TextEditingController get weightController => _weightController;
  TextEditingController get heightController => _heightController;
  GlobalKey<FormState> get formKey => _formKey;
  double get bmi => _bmi;
}
