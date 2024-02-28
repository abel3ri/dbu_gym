import 'package:dbu_gym/models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];
  String? _categoryName;

  set setExercises(List<Exercise> exercises) {
    _exercises = exercises;
    notifyListeners();
  }

  set setCategoryName(String categoryName) {
    _categoryName = categoryName;
    notifyListeners();
  }

  List<Exercise> get exercises => _exercises;
  String get categoryName => _categoryName!;
}
