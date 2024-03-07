import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpFormDropDownMenuBtn extends StatelessWidget {
  String workoutDays;
  SignUpFormDropDownMenuBtn({
    super.key,
    required this.workoutDays,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: "default",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.grey,
          ),
      items: [
        DropdownMenuItem(
          value: "default",
          child: Text("Select prefered workout type"),
        ),
        DropdownMenuItem(
          value: "strength",
          child: Text("Strength Training"),
        ),
        DropdownMenuItem(
          value: workoutDays == 'oneThree' ? "aerobics" : "aerobicsCardio",
          child: Text(
            workoutDays == 'oneThree'
                ? "Aerobics Training"
                : "Aerobics and Cardio Training",
          ),
        ),
        DropdownMenuItem(
          value: workoutDays == 'oneThree' ? "cardio" : "cardioStrength",
          child: Text(
            workoutDays == 'oneThree'
                ? "Cardio Training"
                : "Cardio and Strength Training",
          ),
        ),
      ],
      onChanged: (value) {},
      validator: dropDownFormFieldValidator,
    );
  }
}
