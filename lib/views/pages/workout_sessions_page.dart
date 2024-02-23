import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/workout_program.dart';
import 'package:flutter/material.dart';

class WorkoutSessionPage extends StatelessWidget {
  const WorkoutSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Workout Sessions",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Every Monday, Wednesday, and Friday",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        WorkoutProgram(workoutDays: "monWedFri", programName: "program 1"),
        Divider(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        WorkoutProgram(workoutDays: "monWedFri", programName: "program 2"),
        Divider(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        WorkoutProgram(workoutDays: "monWedFri", programName: "program 3"),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Every Tuesday, Thursday, and Saturday",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        WorkoutProgram(programName: "program 1", workoutDays: "tueThuSat"),
        Divider(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        WorkoutProgram(programName: "program 2", workoutDays: "tueThuSat"),
        Divider(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        WorkoutProgram(programName: "program 3", workoutDays: "tueThuSat"),
      ],
    );
  }
}
