import 'package:dbu_gym/models/exercise.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:fpdart/fpdart.dart';

class ExerciseController {
  static Future<Either<String, List<Exercise>>> getExerciseByMuscleName(
      String muscleName) async {
    try {
      final res = await dio.get(
        exerciseAPIUrl,
        queryParameters: {
          "Muscles": muscleName.replaceAll(" ", "_"),
        },
        options: options,
      );

      final data = res.data as List<dynamic>;
      List<Exercise> exercsies = [];

      data.forEach((exercise) {
        exercsies.add(Exercise(
          name: exercise['WorkOut'],
          muscle: exercise['Muscles'],
          equipment: exercise['Equipment'] ?? "Not required",
          difficulty: exercise['Intensity_Level'],
          explanation: exercise['Long Explanation'],
          beginnerSets: exercise['Beginner Sets'],
          intermediateSets: exercise['Intermediate Sets'],
          expertSets: exercise['Expert Sets'],
          videoUrl: exercise['Video'],
        ));
      });
      return right(exercsies);
    } catch (err) {
      return left(err.toString());
    }
  }

  static Future<Either<String, List<Exercise>>> getExerciseByDifficulty(
      String difficulty) async {
    try {
      final res = await dio.get(
        exerciseAPIUrl,
        queryParameters: {
          "Intensity_Level": difficulty.replaceAll(" ", "_"),
        },
        options: options,
      );

      final data = res.data as List<dynamic>;
      List<Exercise> exercsies = [];

      data.forEach((exercise) {
        exercsies.add(Exercise(
          name: exercise['WorkOut'],
          muscle: exercise['Muscles'],
          equipment: exercise['Equipment'] ?? "Not required",
          difficulty: exercise['Intensity_Level'],
          explanation: exercise['Long Explanation'],
          beginnerSets: exercise['Beginner Sets'],
          intermediateSets: exercise['Intermediate Sets'],
          expertSets: exercise['Expert Sets'],
          videoUrl: exercise['Video'],
        ));
      });
      return right(exercsies);
    } catch (err) {
      return left(err.toString());
    }
  }

  static Future<Either<String, List<Exercise>>> getExerciseByEquipmentType(
      String equipment) async {
    try {
      final res = await dio.get(
        exerciseAPIUrl,
        queryParameters: {
          "Equipment": equipment.replaceAll(" ", "_"),
        },
        options: options,
      );

      final data = res.data as List<dynamic>;
      List<Exercise> exercsies = [];

      data.forEach((exercise) {
        exercsies.add(Exercise(
          name: exercise['WorkOut'],
          muscle: exercise['Muscles'],
          equipment: exercise['Equipment'] ?? "Not required",
          difficulty: exercise['Intensity_Level'],
          explanation: exercise['Long Explanation'],
          beginnerSets: exercise['Beginner Sets'],
          intermediateSets: exercise['Intermediate Sets'],
          expertSets: exercise['Expert Sets'],
          videoUrl: exercise['Video'],
        ));
      });
      return right(exercsies);
    } catch (err) {
      return left(err.toString());
    }
  }
}
