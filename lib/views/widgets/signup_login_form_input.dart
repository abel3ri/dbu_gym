// ignore_for_file: must_be_immutable

import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormInputField extends StatelessWidget {
  FormInputField({
    super.key,
    this.showPassword = false,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.formType = "",
  });

  bool showPassword;
  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;
  String formType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        suffixIcon: labelText == "Password"
            ? IconButton(
                onPressed: () {
                  Provider.of<FormProvider>(context, listen: false)
                      .toggleShowPassword();
                },
                icon: Icon(
                    !showPassword ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
      obscureText: labelText.toLowerCase().contains("password") && !showPassword
          ? true
          : false,
      // Change text input action for email input (always) and password input (if we are in the sign up page)
      textInputAction: (labelText == "E-mail" ||
              (formType == "Sign up" && labelText == "Password"))
          ? TextInputAction.next
          : TextInputAction.done,
      validator: labelText == "E-mail"
          ? emailValidator
          : labelText.contains("name")
              ? nameValidator
              : (value) => passwordValidator(
                    value: value,
                    context: context,
                    formType: formType,
                  ),
    );
  }
}
