import 'package:dbu_gym/providers/bmi_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BMIInputField extends StatelessWidget {
  late TextEditingController controller;
  late String inputName;
  late BMIProvider bmiProvider;
  BMIInputField({
    super.key,
    required this.controller,
    required this.inputName,
    required this.bmiProvider,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      textInputAction: inputName == 'weightInput'
          ? TextInputAction.next
          : TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) {
        try {
          if (value!.isEmpty) return "Please provide this field.";
          // check parsing the input value
          // if it fails, it throws FormatException, will be catched
          double.parse(value);
          return null;
        } on FormatException catch (_) {
          return "Invalid input";
        }
      },
    );
  }
}
