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
  List<Exercise>? _exercises;

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
            .toList();
        notifyListeners();
      } else if (_categoryName == "difficulty") {
        _exercises = this
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
            .toList();
        notifyListeners();
      } else if (_categoryName == 'exercise') {
        _exercises = this
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
            .toList();
        notifyListeners();
      } else {
        // print(_searchParamter);
        _exercises = this
            .allExercises
            .filter((exercise) {
              if (exercise['equipment'] != null)
                return exercise['equipment'].contains(_searchParamter);
              return false;
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
            .toList();
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
