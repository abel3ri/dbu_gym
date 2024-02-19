// ignore_for_file: must_be_immutable

import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:dbu_gym/controllers/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final formProvider = Provider.of<FormProvider>(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        hintText: "MM-DD-YYYY",
        prefixIcon: Icon(Icons.date_range),
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

          Provider.of<FormProvider>(context, listen: false)
              .changeDateInputValue(picked_date, labelText);
        } catch (e) {
          print(e.toString());
        }
      },
      validator: (value) {
        if (value!.isEmpty) return "${labelText} is required.";
        return dateValidator(
          context: context,
          startDate: formProvider.startDateController.text,
          endDate: formProvider.endDateController.text,
        );
      },
    );
  }
}
