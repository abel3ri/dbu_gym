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

String? passwordValidator(String? value) {
  if (value!.isEmpty) return "Please provide a password.";
  if (value.length < 8) return "Password must be at least 8 characters";
  return null;
}

String? dateValidator({
  required String startDate,
  required String endDate,
  required BuildContext context,
}) {
  // parse string dates to actual DateTime objs
  DateTime sDate = DateTime.parse(startDate);
  DateTime eDate = DateTime.parse(endDate);
  print((eDate.millisecondsSinceEpoch - sDate.millisecondsSinceEpoch) /
      (1000 * 60 * 60 * 24).toInt());
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  if (sDate.isBefore(DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch - 24 * 60 * 60 * 1000))) {
    formProvider.toggleDateInputError();
    formProvider
        .setDateInputStr("Gym start date shouldn't preceed today's date.");
    return "";
  }
  if (eDate.isBefore(DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch - 24 * 60 * 60 * 1000))) {
    formProvider.toggleDateInputError();
    formProvider
        .setDateInputStr("Gym end date shouldn't preceed today's date.");
    return "";
  }
  if ((eDate.millisecondsSinceEpoch - sDate.millisecondsSinceEpoch) /
          (1000 * 60 * 60 * 24).toInt() !=
      30) {
    formProvider.toggleDateInputError();
    formProvider.setDateInputStr("The date difference should be 30 days.");
    return "";
  }

  if (sDate.isAfter(eDate)) {
    formProvider.toggleDateInputError();
    formProvider.setDateInputStr("Start Date should not exceed End Date.");
    return "";
  }
  formProvider.toggleDateInputSuccess();
  return null;
}

String? dateInputValidator(String? value, String inputName) {
  if (value!.isEmpty) return "${inputName} is required.";
  return null;
}

String? nameValidator(String? value) {
  RegExp regExp = RegExp("[a-zA-Z]");
  if (value!.isEmpty) return "Name is required";
  if (!regExp.hasMatch(value)) return "Please prvoide valid name";
  return null;
}

String? dropDownFormFieldValidator(String? value) {
  if (['default', 'default1-3', 'default4-6'].contains(value))
    return "Please provide this field.";
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value!.isEmpty) return "Please provide a phone number.";
  return null;
}

// check if password and re entered password are the same
void passRepassValidator({
  required TextEditingController passController,
  required TextEditingController rePassController,
  required BuildContext context,
}) {
  if (passController.text != rePassController.text) {
    Provider.of<FormProvider>(context, listen: false)
        .sethasPassRepassInputError(true);
  } else {
    Provider.of<FormProvider>(context, listen: false)
        .sethasPassRepassInputError(false);
  }
}
