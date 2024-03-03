import 'dart:typed_data';

import 'package:dbu_gym/providers/exercises_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    final exercise = exerciseProvider.exercise;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.darken(10),
        elevation: 0,
        title: Text(exercise!.name),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            Provider.of<ExercisesProvider>(context, listen: false)
                .getExercises();
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary.darken(10),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: constraints.maxHeight * 0.4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.darken(10),
                  ),
                  child: FutureBuilder(
                    future: exerciseProvider.convertJpgToPdf(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child:
                                CircularProgressIndicator(color: Colors.white));
                      } else {
                        return snapshot.data!.isLeft()
                            ? Text(snapshot.data!.getLeft().toString())
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.memory(
                                  Uint8List.fromList(
                                    snapshot.data!.getOrElse((r) => null)!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              );
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: constraints.maxHeight * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ExerciseAttributeRow(
                          attributeName: "Primary muscle",
                          attributeValue: exercise.primaryMuscle.capitalize,
                        ),
                        Divider(height: constraints.maxHeight * 0.04),
                        ExerciseAttributeRow(
                            attributeName: "Difficulty level",
                            attributeValue: exercise.level.capitalize),
                        Divider(height: constraints.maxHeight * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Category",
                          attributeValue: exercise.category.capitalize,
                        ),
                        Divider(height: constraints.maxHeight * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Force",
                          attributeValue: exercise.force == null
                              ? "-"
                              : exercise.force!.capitalize,
                        ),
                        Divider(height: constraints.maxHeight * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Mechanic",
                          attributeValue: exercise.mechanic == null
                              ? "-"
                              : exercise.mechanic!.capitalize,
                        ),
                        Divider(height: constraints.maxHeight * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Equipment",
                          attributeValue: exercise.equipment == null
                              ? "-"
                              : exercise.equipment!.capitalize,
                        ),
                        Divider(height: constraints.maxHeight * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Secondary Muscles",
                          attributeValue: exercise.equipment == null
                              ? "-"
                              : exercise.secondaryMuscles,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ExerciseAttributeRow extends StatelessWidget {
  ExerciseAttributeRow({
    super.key,
    required this.attributeName,
    required this.attributeValue,
  });

  String attributeName;
  dynamic attributeValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attributeName),
        attributeName == 'Secondary Muscles'
            ? (attributeValue as List<String>).isEmpty
                ? Text("None")
                : Wrap(
                    children: (attributeValue as List<String>)
                        .map(
                          (e) => Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            label: Text(e.capitalize),
                            padding: EdgeInsets.zero,
                          ),
                        )
                        .toList(),
                  )
            : Text(attributeValue),
      ],
    );
  }
}
