import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  final _fromKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  // void

  get showPassword => _showPassword;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get rePasswordController => _rePasswordController;
  get formKey => _fromKey;
}
