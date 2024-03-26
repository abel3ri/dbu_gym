import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:dbu_gym/providers/exercises_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExerciseCategory extends StatelessWidget {
  const ExerciseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final exercisesProvider = Provider.of<ExercisesProvider>(context);
    final exercises = exercisesProvider.exercises;
    String categoryName = exercisesProvider.categoryName;

    // check if the exercises list is not empty and the category name and assign image path and text dynamically to increase readability of code

    String? _imgPath;
    String? _exerciseName;

    if (categoryName == 'muscle') {
      _imgPath =
          "assets/images/grid_images/${categoryName}/${exercises[0].primaryMuscle.replaceAll(" ", "_")}.png";
      _exerciseName = exercises[0].primaryMuscle;
      categoryName = categoryName + " Group";
    } else if (categoryName == 'exercise') {
      _imgPath =
          "assets/images/grid_images/${categoryName}/${exercises[0].category.replaceAll(" ", "_")}.png";
      _exerciseName = exercises[0].category.length >= 15
          ? exercises[0].category.substring(0, 11) + "..."
          : exercises[0].category;
      categoryName = categoryName + " Category";
    } else if (categoryName == 'equipment') {
      _imgPath =
          "assets/images/grid_images/${categoryName}/${exercises[0].equipment!.replaceAll(' ', '_')}.png";

      _exerciseName = exercises[0].equipment ?? 'Not Required';
      categoryName = categoryName + " Name";
    } else {
      _imgPath = "assets/images/grid_images/equipment/placeholder.png";
      _exerciseName = exercises[0].level;
      categoryName = categoryName + " Level";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background.darken(20),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
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
            // color: Colors.grey.shade200,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: exercises.isEmpty
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
                        color:
                            Theme.of(context).colorScheme.background.darken(20),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Image.asset(
                                  _imgPath,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoryName.capitalize,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _exerciseName.length >= 15
                                          ? 12.5
                                          : null,
                                      letterSpacing: 2,
                                    ),
                              ),
                              Text(
                                _exerciseName.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: _exerciseName.length <= 12
                                          ? 2.5
                                          : null,
                                      fontSize: _exerciseName.length >= 15
                                          ? 14
                                          : null,
                                      // color: Colors.white,
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
                        color:
                            Theme.of(context).colorScheme.background.darken(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        padding: EdgeInsets.only(right: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width: constraints.maxWidth * 0.15,
                                ),
                              ),
                              Text(
                                "${exercises.length} exercises",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              PopupMenuButton(
                                elevation: 0,
                                color: Theme.of(context).colorScheme.background
                                // .darken(20),
                                ,
                                tooltip: "Filter",
                                initialValue: "name",
                                onSelected: (value) {
                                  exercisesProvider.sortExercises(value);
                                },
                                icon: Icon(
                                  Icons.tune,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("Sort by name"),
                                    value: "name",
                                  ),
                                  PopupMenuItem(
                                    child:
                                        Text("Sort by difficulty level - Asc"),
                                    value: "level-asc",
                                  ),
                                  PopupMenuItem(
                                    child:
                                        Text("Sort by difficulty level- Dec"),
                                    value: "level-dec",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: exercises.length,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            surfaceTintColor: Colors.transparent,
                            color: Theme.of(context)
                                .colorScheme
                                .background
                                .darken(3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: ListTile(
                              splashColor: Colors.transparent,
                              onTap: () {
                                Provider.of<ExerciseProvider>(context,
                                        listen: false)
                                    .setExercise(exercises[index]);
                                GoRouter.of(context).pushNamed(
                                  "exercise-details-page",
                                );
                              },
                              leading: Text(
                                exercises[index].name.length > 25
                                    ? exercises[index].name.substring(0, 26) +
                                        "..."
                                    : exercises[index].name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: exercises[index].level ==
                                              'beginner'
                                          ? Colors.greenAccent.shade400
                                              .withOpacity(0.6)
                                          : exercises[index].level == 'expert'
                                              ? Colors.redAccent.darken(10)
                                              : Colors.yellowAccent.shade700
                                                  .darken(5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    child: Text(
                                      exercises[index].level.capitalize,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    exercises[index].category.capitalize,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  )
                                ],
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
