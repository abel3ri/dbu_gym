// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SignUpLoginButton extends StatelessWidget {
  late String buttonName;
  late String btnText;
  void Function() onPressed;
  SignUpLoginButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(btnText),
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(120, 44)),
      ),
    );
  }
}
