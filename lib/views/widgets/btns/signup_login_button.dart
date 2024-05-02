// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SignUpLoginButton extends StatelessWidget {
  late String buttonName;
  void Function() onPressed;
  SignUpLoginButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(buttonName),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(120, 44)),
      ),
    );
  }
}
