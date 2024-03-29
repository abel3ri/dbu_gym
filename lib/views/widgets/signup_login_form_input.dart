// ignore_for_file: must_be_immutable
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
    required this.validator,
    this.hintText,
    this.formType = "",
  });

  bool showPassword;
  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;
  String formType;
  String? hintText;
  String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey,
            ),
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
              (formType == "Sign up" && labelText == "Password") ||
              labelText == 'Re-enter password')
          ? TextInputAction.next
          : TextInputAction.done,
      keyboardType: labelText == 'E-mail'
          ? TextInputType.emailAddress
          : ['Password', "Re-enter password"].contains(labelText)
              ? TextInputType.visiblePassword
              : labelText == 'Phone number'
                  ? TextInputType.phone
                  : null,
      validator: validator,
    );
  }
}
