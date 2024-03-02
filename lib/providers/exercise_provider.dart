import 'package:dbu_gym/models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseProvider with ChangeNotifier {
  Exercise? _exercise;

  void setExercise(Exercise exercise) {
    if (_exercise != null) _exercise = null;
    _exercise = exercise;
    notifyListeners();
  }

  Exercise? get exercise => _exercise!;
}
