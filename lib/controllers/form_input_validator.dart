import "package:dbu_gym/controllers/providers/form_provider.dart";
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
  required String startDate,
  required String endDate,
  required BuildContext context,
}) {
  if (DateTime.parse(startDate).isAfter(DateTime.parse(endDate))) {
    Provider.of<FormProvider>(context, listen: false).toggleDateInputError();

    return "";
  }
  Provider.of<FormProvider>(context, listen: false).toggleDateInputSuccess();
  return null;
}
