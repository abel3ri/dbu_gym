// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DatePickerInputField extends StatelessWidget {
  String labelText;
  String helpText;
  TextEditingController controller;
  DatePickerInputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        hintText: "MM/DD/YY",
        prefixIcon: Icon(Icons.date_range),
        prefixIconColor: Colors.grey,
      ),
      keyboardType: TextInputType.datetime,
      onTap: () {
        showDatePicker(
          context: context,
          firstDate: DateTime(2000, 01, 01),
          lastDate: DateTime(2030, 01, 01),
          helpText: helpText,
          fieldLabelText: helpText,
        );
      },
      validator: (value) {
        if (value!.isEmpty) return "${labelText} is required.";
        return null;
      },
    );
  }
}
