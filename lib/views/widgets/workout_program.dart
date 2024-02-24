import 'package:dbu_gym/utils/constants.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 9, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            programName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12.5,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
