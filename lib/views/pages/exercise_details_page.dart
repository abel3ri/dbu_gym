import 'dart:typed_data';

import 'package:dbu_gym/views/widgets/exercise_attribute_row.dart';
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
        backgroundColor: Theme.of(context).colorScheme.background.darken(20),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(exercise!.name),
        titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            // color: Colors.white,
            ),
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background.darken(20),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: constraints.maxHeight * 0.4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background.darken(20),
                  ),
                  child: FutureBuilder(
                    future: exerciseProvider.convertJpgToPdf(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        ExerciseAttributeRow(
                            attributeName: "Difficulty level",
                            attributeValue: exercise.level.capitalize),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Category",
                          attributeValue: exercise.category.capitalize,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Force",
                          attributeValue: exercise.force == null
                              ? "-"
                              : exercise.force!.capitalize,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Mechanic",
                          attributeValue: exercise.mechanic == null
                              ? "-"
                              : exercise.mechanic!.capitalize,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Equipment",
                          attributeValue: exercise.equipment == null
                              ? "-"
                              : exercise.equipment!.capitalize,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        ExerciseAttributeRow(
                          attributeName: "Secondary Muscles",
                          attributeValue: exercise.secondaryMuscles,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        Column(
                          children: [
                            Text(
                              "Instructions",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            ...exercise.instructions
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background
                                          .darken(4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          child: Text(
                                            "${exercise.instructions.indexOf(e) + 1}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Colors.grey.shade300,
                                                ),
                                          ),
                                          radius: 14,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        Flexible(
                                          child: Wrap(
                                            children: [
                                              Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      height: 1.6,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        )
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
