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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.darken(10),
        elevation: 0,
        title: Text(exerciseProvider.exercise!.name),
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
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
