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

  void dynamicToExerciseMapper() {
    _exercises = this.allExercises.map((e) {
      return Exercise(
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
      );
    }).toList();
  }

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
        _exercises = _exercises!.where((exercise) {
          return exercise.primaryMuscle.contains(_searchParamter!);
        }).toList();
        notifyListeners();
      } else if (_categoryName == "difficulty") {
        _exercises = _exercises!.where((exercise) {
          return exercise.level.contains(_searchParamter!);
        }).toList();
        notifyListeners();
      } else if (_categoryName == 'exercise') {
        _exercises = _exercises!.where((exercise) {
          return exercise.category.contains(_searchParamter!);
        }).toList();
        notifyListeners();
      } else {
        _exercises = _exercises!.where((exercise) {
          if (exercise.equipment != null)
            return exercise.equipment!.contains(_searchParamter!);
          return false;
        }).toList();
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  String get searchParamter => _searchParamter!;
  String get categoryName => _categoryName!;
  List<Exercise> get exercises => _exercises!;
}
