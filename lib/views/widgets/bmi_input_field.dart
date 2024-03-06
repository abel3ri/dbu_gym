import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BMIInputField extends StatelessWidget {
  late TextEditingController controller;
  late String inputName;
  BMIInputField({
    super.key,
    required this.controller,
    required this.inputName,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.background.darken(5),
        hintText: inputName == 'weightInput'
            ? "Enter your weight"
            : "Enter your height",
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey,
            ),
        suffixText: inputName == 'weightInput' ? "Killograms" : "Meters",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
