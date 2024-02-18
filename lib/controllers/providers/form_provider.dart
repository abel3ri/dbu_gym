import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  bool _hasDateInputError = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void changeDateInputValue(String value, String labelText) {
    if (labelText == "Start Date") {
      _startDateController.text = value;
    } else {
      _endDateController.text = value;
    }
    notifyListeners();
  }

  void toggleDateInputError() {
    _hasDateInputError = true;
    notifyListeners();
  }

  void toggleDateInputSuccess() {
    _hasDateInputError = false;
    notifyListeners();
  }
  // void

  get showPassword => _showPassword;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get rePasswordController => _rePasswordController;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;
  bool get hasDateInputError => _hasDateInputError;
}
