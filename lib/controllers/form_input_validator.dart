import "package:dbu_gym/providers/form_provider.dart";
import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

String? emailValidator(String? value) {
  if (value!.isEmpty) return "Please provide an email address.";
  if (!EmailValidator.validate(value))
    return "Please provide a valid email address";
  return null;
}

String? passwordValidator({
  required String? value,
  required String formType,
  required BuildContext context,
}) {
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  if (value!.isEmpty) return "Please provide a password.";

  if (value.length < 8) return "Password must be at least 8 characters";
  if (formType == "Sign up" &&
      formProvider.passwordController.text !=
          formProvider.rePasswordController.text) {
    return "Password do not match.";
  }
  return null;
}

String? dateValidator({
  required DateTime startDate,
  required DateTime endDate,
  required BuildContext context,
}) {
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  if (startDate.isBefore(DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch - 24 * 60 * 60 * 1000)) ||
      endDate.isBefore(DateTime.now())) {
    formProvider.toggleDateInputError();
    formProvider.setDateInputStr("Invalid Date Entered.");
    return "";
  }

  if (startDate.isAfter(endDate)) {
    formProvider.toggleDateInputError();
    formProvider.setDateInputStr("Start Date should not exceed End Date.");
    return "";
  }
  formProvider.toggleDateInputSuccess();
  return null;
}

String? nameValidator(String? value) {
  RegExp regExp = RegExp("[a-zA-Z]");
  if (value!.isEmpty) return "Name is required";
  if (!regExp.hasMatch(value)) return "Please prvoide valid name";
  return null;
}

String? dropDownFormFieldValidator(String? value) {
  if (value == 'default') return "Please provide this field.";
  return null;
}
