import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  final _fromKey = GlobalKey<FormState>();

  bool _showPassword = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  // void

  get showPassword => _showPassword;

  get formKey => _fromKey;
}
