import 'package:dbu_gym/utils/constants.dart';
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

// ignore: must_be_immutable
class WorkoutProgram extends StatelessWidget {
  String programName;
  String workoutDays;
  WorkoutProgram({
    super.key,
    required this.programName,
    required this.workoutDays,
  });

  @override
  Widget build(BuildContext context) {
    print(workoutDays);
    print(programName);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          programName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...workoutSessionContent[workoutDays]![programName]!.map(
              (content) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        // fontSize: 2,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
