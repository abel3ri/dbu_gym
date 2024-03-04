// import 'package:dbu_gym/models/exercise.dart';

import 'package:dbu_gym/models/exercise.dart';
import 'package:flutter/material.dart';

class ExercisesProvider with ChangeNotifier {
  List<dynamic> allExercises = [];
  ExercisesProvider({
    required this.allExercises,
  });

  String? _searchParamter;
  String? _categoryName;
  List<Exercise>? _exercises;

  // void dynamicToExerciseTypeMapper() {
  //   _exercises = this.allExercises.map((e) {
  //     return Exercise(
  //       name: e['name'],
  //       primaryMuscle: e['primaryMuscles'][0],
  //       equipment: e['equipment'],
  //       level: e['level'],
  //       mechanic: e['mechanic'],
  //       force: e['force'],
  //       secondaryMuscles: List<String>.from(e['secondaryMuscles']),
  //       instructions: List<String>.from(e['instructions']),
  //       category: e['category'],
  //       images: List<String>.from(e['images']),
  //     );
  //   }).toList();
  // }

  set setSearchParamter(String value) {
    _searchParamter = value;
    notifyListeners();
  }

  set setCategoryName(String value) {
    _categoryName = value;
    notifyListeners();
  }

  void getExercises() {
    try {
      if (_categoryName == "muscle") {
        _exercises = this
            .allExercises
            .where((e) {
              return List.from(e['primaryMuscles'])[0] == _searchParamter;
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'] as String,
                primaryMuscle: List.from(e['primaryMuscles'])[0],
                equipment: e['equipment'] as String?,
                level: e['level'] as String,
                mechanic: e['mechanic'] as String?,
                force: e['force'] as String?,
                secondaryMuscles: List.from(e['secondaryMuscles']),
                instructions: List.from(['instructions']),
                category: e['category'] as String,
                images: List.from(e['images']),
              ),
            )
            .toList();
        notifyListeners();
      } else if (_categoryName == "difficulty") {
        _exercises = this
            .allExercises
            .where((e) {
              return e['level'] == _searchParamter;
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'] as String,
                primaryMuscle: List.from(e['primaryMuscles'])[0],
                equipment: e['equipment'] as String?,
                level: e['level'] as String,
                mechanic: e['mechanic'] as String?,
                force: e['force'] as String?,
                secondaryMuscles: List.from(e['secondaryMuscles']),
                instructions: List.from(['instructions']),
                category: e['category'] as String,
                images: List.from(e['images']),
              ),
            )
            .toList();
        notifyListeners();
      } else if (_categoryName == 'exercise') {
        _exercises = this
            .allExercises
            .where((e) {
              return e['category'] == _searchParamter;
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'] as String,
                primaryMuscle: List.from(e['primaryMuscles'])[0],
                equipment: e['equipment'] as String?,
                level: e['level'] as String,
                mechanic: e['mechanic'] as String?,
                force: e['force'] as String?,
                secondaryMuscles: List.from(e['secondaryMuscles']),
                instructions: List.from(['instructions']),
                category: e['category'] as String,
                images: List.from(e['images']),
              ),
            )
            .toList();
        notifyListeners();
      } else {
        _exercises = this
            .allExercises
            .where((e) {
              if (e['equipment'] != null)
                return e['equipment'] == _searchParamter;
              return false;
            })
            .toList()
            .map(
              (e) => Exercise(
                name: e['name'] as String,
                primaryMuscle: List.from(e['primaryMuscles'])[0],
                equipment: e['equipment'] as String?,
                level: e['level'] as String,
                mechanic: e['mechanic'] as String?,
                force: e['force'] as String?,
                secondaryMuscles: List.from(e['secondaryMuscles']),
                instructions: List.from(['instructions']),
                category: e['category'] as String,
                images: List.from(e['images']),
              ),
            )
            .toList();
        notifyListeners();
      }
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  String get searchParamter => _searchParamter!;
  String get categoryName => _categoryName!;
  List<Exercise> get exercises => _exercises!;
}
