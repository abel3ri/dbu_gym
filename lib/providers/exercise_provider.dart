// import 'package:dbu_gym/models/exercise.dart';
import 'package:dbu_gym/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ExerciseProvider with ChangeNotifier {
  List allExercises = [];
  ExerciseProvider({
    required this.allExercises,
  });

  String? _searchParamter;
  String? _categoryName;

  set setSearchParamter(String value) {
    _searchParamter = value;
    notifyListeners();
  }

  set setCategoryName(String value) {
    _categoryName = value;
    notifyListeners();
  }

  Either<String, List<Exercise>> getExercises() {
    try {
      if (_categoryName == "muscle") {
        return right(this
            .allExercises
            .filter((exercise) {
              return (exercise['primaryMuscles'] as List)
                  .contains(_searchParamter);
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'],
                primaryMuscle: e['primaryMuscles'][0],
                equipment: e['equipment'],
                level: e['level'],
                mechanic: e['mechanic'],
                force: e['force'],
                secondaryMuscles: List<String>.from(['secondaryMuscles']),
                instructions: List<String>.from(e['instructions']),
                category: e['category'],
                images: List<String>.from(e['images']),
              ),
            )
            .toList());
      } else if (_categoryName == "difficulty") {
        return right(this
            .allExercises
            .filter((exercise) {
              return (exercise['level']).contains(_searchParamter);
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'],
                primaryMuscle: e['primaryMuscles'][0],
                equipment: e['equipment'],
                level: e['level'],
                mechanic: e['mechanic'],
                force: e['force'],
                secondaryMuscles: List<String>.from(['secondaryMuscles']),
                instructions: List<String>.from(e['instructions']),
                category: e['category'],
                images: List<String>.from(e['images']),
              ),
            )
            .toList());
      } else if (_categoryName == 'exercise') {
        return right(this
            .allExercises
            .filter((exercise) {
              return (exercise['category']).contains(_searchParamter);
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'],
                primaryMuscle: e['primaryMuscles'][0],
                equipment: e['equipment'],
                level: e['level'],
                mechanic: e['mechanic'],
                force: e['force'],
                secondaryMuscles: List<String>.from(['secondaryMuscles']),
                instructions: List<String>.from(e['instructions']),
                category: e['category'],
                images: List<String>.from(e['images']),
              ),
            )
            .toList());
      }

      return right(this
          .allExercises
          .filter((exercise) {
            return exercise['name'].contains(_searchParamter);
            // exercise['equipment'].contains(_searchParamter);
          })
          .toList()
          .map(
            (e) => Exercise(
              name: e['name'],
              primaryMuscle: e['primaryMuscles'][0],
              equipment: e['equipment'],
              level: e['level'],
              mechanic: e['mechanic'],
              force: e['force'],
              secondaryMuscles: List<String>.from(['secondaryMuscles']),
              instructions: List<String>.from(e['instructions']),
              category: e['category'],
              images: List<String>.from(e['images']),
            ),
          )
          .toList());
    } catch (err) {
      return left(err.toString());
    }
  }

  String get searchParamter => _searchParamter!;
  String get categoryName => _categoryName!;
}
