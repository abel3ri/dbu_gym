import 'dart:math';

import 'package:dbu_gym/models/exercise.dart';
import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExerciseCategory extends StatelessWidget {
  const ExerciseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    final String categoryName = exerciseProvider.categoryName;
    List<Exercise>? exercises;
    bool isExercisesEmpty = false;

    exerciseProvider.getExercises().fold((err) {
      if (err.isNotEmpty) print(err);
      return GoRouter.of(context).pushReplacementNamed("home");
    }, (res) {
      isExercisesEmpty = res.isEmpty;
      exercises = res;
    });

    // check if the exercises list is not empty and the category name and assign image path and text dynamically to increase readability of code

    String? _imgPath;
    String? _text;

    if (!isExercisesEmpty) {
      if (categoryName == 'muscle') {
        _imgPath =
            "assets/images/grid_images/${categoryName}/${exercises![0].primaryMuscle.replaceAll(" ", "_")}.png";
        _text = exercises![0].primaryMuscle;
      } else if (categoryName == 'exercise') {
        _imgPath =
            "assets/images/grid_images/${categoryName}/${exercises![0].category.replaceAll(" ", "_")}.png";
        _text = exercises![0].category;
      } else if (categoryName == 'equipment') {
        _imgPath = "assets/images/grid_images/${categoryName}/placeholder.png";

        _text = exercises![0].equipment ?? 'Not Required';
      } else {
        _imgPath = "assets/images/grid_images/equipment/placeholder.png";
        _text = exercises![0].level;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: exercises!.isEmpty
              ? Center(
                  child: Text("No exercises found!"),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(32, 0, 48, 8),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      (Random().nextDouble() * 40) + 20),
                                  topRight: Radius.circular(
                                      (Random().nextDouble() * 20) + 20),
                                  bottomRight: Radius.circular(
                                      (Random().nextDouble() * 30) + 20),
                                  bottomLeft: Radius.circular(
                                      (Random().nextDouble() * 60) + 20),
                                ),
                              ),
                              child: Image.asset(
                                _imgPath!,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                exerciseProvider.categoryName.capitalize,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade200,
                                    ),
                              ),
                              Text(
                                _text!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontFamily: "SwankyAndMooMoo",
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: exercises!.length,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0.8,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: ListTile(
                              leading: Text(
                                exercises![index].name.length > 25
                                    ? exercises![index].name.substring(0, 26) +
                                        "..."
                                    : exercises![index].name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: exercises![index].level == 'beginner'
                                      ? Colors.greenAccent.shade400
                                          .withOpacity(0.6)
                                      : exercises![index].level == 'expert'
                                          ? Colors.redAccent.darken(10)
                                          : Colors.yellowAccent.shade700
                                              .darken(5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                child: Text(
                                  exercises![index].level.capitalize,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
