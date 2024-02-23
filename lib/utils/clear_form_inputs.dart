import 'package:dbu_gym/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void clearFormInputs(BuildContext context) {
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  formProvider.emailController.clear();
  formProvider.passwordController.clear();
  formProvider.rePasswordController.clear();
  formProvider.startDateController.clear();
  formProvider.endDateController.clear();
  formProvider.firstNameController.clear();
  formProvider.lastNameController.clear();
}
