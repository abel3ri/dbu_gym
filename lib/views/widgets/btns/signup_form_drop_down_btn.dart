import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpFormDropDownMenuBtn extends StatelessWidget {
  String workoutDays;
  SignUpFormDropDownMenuBtn({
    super.key,
    required this.workoutDays,
  });

  // display different dropdownmenuitem content based on the selected workout days
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    return DropdownButtonFormField(
      value: workoutDays == 'oneThree' ? 'default1-3' : "default4-6",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.grey,
          ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      items: [
        DropdownMenuItem(
          value: workoutDays == 'oneThree' ? 'default1-3' : "default4-6",
          child: Text(
            "Select prefered workout type",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        DropdownMenuItem(
          value: "strength",
          child: Text("Strength Training"),
        ),
        DropdownMenuItem(
          value: workoutDays == 'oneThree' ? "aerobics" : "aerobics_cardio",
          child: Text(
            workoutDays == 'oneThree'
                ? "Aerobics Training"
                : "Aerobics and Cardio Training",
          ),
        ),
        DropdownMenuItem(
          value: workoutDays == 'oneThree' ? "cardio" : "cardio_strength",
          child: Text(
            workoutDays == 'oneThree'
                ? "Cardio Training"
                : "Cardio and Strength Training",
          ),
        ),
      ],
      onChanged: (value) {
        formProvider.setPreferedWorkoutType(value!);
      },
      validator: dropDownFormFieldValidator,
    );
  }
}
