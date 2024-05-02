// ignore_for_file: must_be_immutable

import 'package:dbu_gym/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerInputField extends StatelessWidget {
  String labelText;
  String helpText;
  TextEditingController controller;
  String? Function(String? value) validator;
  DatePickerInputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.helpText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
        hintText: "MM-DD-YYYY",
        prefixIcon: Icon(Icons.date_range),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        prefixIconColor: Colors.grey,
        errorText: formProvider.hasDateInputError ? "" : null,
      ),
      keyboardType: TextInputType.datetime,
      readOnly: true,
      onTap: () async {
        try {
          DateTime? date = await showDatePicker(
            context: context,
            firstDate: DateTime(2000, 01, 01),
            lastDate: DateTime(2030, 01, 01),
            helpText: helpText,
            fieldLabelText: helpText,
            fieldHintText: "MM/DD/YYYY",
          );
          String picked_date =
              "${date!.year.toString().padLeft(2, "0")}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}";

          controller.text = picked_date;
        } catch (e) {
          print(e.toString());
        }
      },
      validator: validator,
    );
  }
}
