import 'package:dbu_gym/models/exercise.dart';
import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:dbu_gym/providers/exercises_provider.dart';
import 'package:dbu_gym/providers/home_page_grid_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/pages/search_page.dart';
import 'package:dbu_gym/views/widgets/app_drawer.dart';
import 'package:dbu_gym/views/widgets/home_page_grid.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<HomePageGridProvider>(context);
    final exercisesProvider = Provider.of<ExercisesProvider>(context);
    final exerciseProvider = Provider.of<ExerciseProvider>(context);

    // map allExercises from List<dynamic> to List<Exercise> before doing any filtering
    exercisesProvider.dynamicToExerciseMapper();

    return AppZoomDrawer(
      title: GestureDetector(
        onTap: () async {
          try {
            final Exercise exercise = await showSearch(
              context: context,
              delegate: SearchPage(exercises: exercisesProvider.exercises),
            );
            exerciseProvider.setExercise(exercise);
            GoRouter.of(context).pushNamed("exercise-details-page");
          } catch (err) {
            print("No exercise selected.");
          }
        },
        child: Container(
          height: 48,
          padding: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.darken(5),
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade500),
              SizedBox(width: 8),
              Text(
                "Search exercise",
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ),
      appBarActions: [
        PopupMenuButton(
          elevation: 0,
          onSelected: (value) {
            // print(value);
            Provider.of<HomePageGridProvider>(context, listen: false)
                .changeCategory(value);
          },
          initialValue: categoryProvider.selectedCategory,
          padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "muscle",
              child: Text("Categorize by muscle group"),
            ),
            PopupMenuItem(
              value: "exercise",
              child: Text("Categorize by exercise type"),
            ),
            PopupMenuItem(
              value: "equipment",
              child: Text("Categorize by equipment type"),
            ),
            PopupMenuItem(
              value: "difficulty",
              child: Text("Categorize by difficulty level"),
            ),
          ],
        ),
      ],
      mainScreen: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(child: Center(child: Text("Workouts"))),
                    Tab(child: Center(child: Text("Calculate BMI"))),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      HomePageGrid(
                        category: categoryProvider.selectedCategory == "muscle"
                            ? muscleGroupCategories
                            : categoryProvider.selectedCategory == "equipment"
                                ? equipmentTypeCategories
                                : categoryProvider.selectedCategory ==
                                        'difficulty'
                                    ? difficultyCategories
                                    : exerciseTypeCategories,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              await auth.signOut();
                              GoRouter.of(context)
                                  .pushReplacementNamed("splash");
                            },
                            child: Text("Sign out")),
                      ),
                    ],
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
