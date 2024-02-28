import 'dart:math';

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
    // print(Provider.of<ExerciseProvider>(context).exercises);
    print(
        "assets/images/grid_images/${exerciseProvider.exercises[0].muscle}.png");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
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
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                          "assets/images/grid_images/${exerciseProvider.exercises[0].muscle.toLowerCase()}.png",
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
                          exerciseProvider.exercises[0].muscle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
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
                  itemCount: exerciseProvider.exercises.length,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0.8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: ListTile(
                        leading: Text(
                          exerciseProvider.exercises[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color:
                                exerciseProvider.exercises[index].difficulty ==
                                        'Beginner'
                                    ? Colors.greenAccent.shade400
                                    : exerciseProvider
                                                .exercises[index].difficulty ==
                                            'Expert'
                                        ? Colors.redAccent
                                        : Colors.yellowAccent.shade700,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Text(
                            exerciseProvider.exercises[index].difficulty,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
