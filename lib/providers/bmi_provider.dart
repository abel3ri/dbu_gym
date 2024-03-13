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
    if (bmi >= 30) {
      return "Your BMI result indicates you are in the obese category. Start taking less calorie foods and make our gym your new home starting from now! 😤";
    } else if (bmi >= 25 && bmi <= 29.9) {
      return "Your BMI result indicates you are in the over weight category. It is recommended to take less calorie food. Try to take short walk after meals, it doesn't hurt 😉";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "Great! Your BMI indicates a healthy weight. Keep doing what you're doing! 👍";
    }
    return "Your BMI result indicates you are in the underweight category. All you need is food and our GYM 😉";
  }

  TextEditingController get weightController => _weightController;
  TextEditingController get heightController => _heightController;
  GlobalKey<FormState> get formKey => _formKey;
  String get bmi => _bmi.toStringAsFixed(2);
}
