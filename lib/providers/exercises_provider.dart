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

  // Generic mapper function after filtering all exercises
  Exercise dynamicToExerciseMapper(Map<dynamic, dynamic> exercise) {
    return Exercise(
      name: exercise['name'] as String,
      primaryMuscle: List.from(exercise['primaryMuscles'])[0],
      equipment: exercise['equipment'] as String?,
      level: exercise['level'] as String,
      mechanic: exercise['mechanic'] as String?,
      force: exercise['force'] as String?,
      secondaryMuscles: List.from(exercise['secondaryMuscles']),
      instructions: List.from(exercise['instructions']),
      category: exercise['category'] as String,
      images: List.from(exercise['images']),
    );
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
        _exercises = this
            .allExercises
            .where((e) {
              return List.from(e['primaryMuscles'])[0] == _searchParamter;
            })
            .toList()
            .map(
              (e) => dynamicToExerciseMapper(e),
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
              (e) => dynamicToExerciseMapper(e),
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
              (e) => dynamicToExerciseMapper(e),
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
              (e) => dynamicToExerciseMapper(e),
            )
            .toList();
        notifyListeners();
      }
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  void sortExercises(String sortValue) {
    Map<String, int> difficultyLevelToNum = {
      "beginner": 1,
      "intermediate": 2,
      "expert": 3,
    };
    if (sortValue == 'name') {
      _exercises!.sort((a, b) => a.name.compareTo(b.name));
      notifyListeners();
    } else if (sortValue == 'level-asc') {
      _exercises!.sort((a, b) => difficultyLevelToNum[a.level]!
          .compareTo(difficultyLevelToNum[b.level]!));
      notifyListeners();
    } else if (sortValue == 'level-dec') {
      _exercises!.sort((a, b) => difficultyLevelToNum[b.level]!
          .compareTo(difficultyLevelToNum[a.level]!));
      notifyListeners();
    }
  }

  String get searchParamter => _searchParamter!;
  String get categoryName => _categoryName!;
  List<Exercise> get exercises => _exercises!;
}
