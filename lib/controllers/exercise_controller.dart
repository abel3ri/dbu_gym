import 'package:dbu_gym/models/exercise.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:fpdart/fpdart.dart';

class ExerciseController {
  String parameter;
  String categoryName;
  ExerciseController({
    required this.parameter,
    required this.categoryName,
  });

  Map<String, String> getParameterObj() {
    if (this.categoryName == 'muscle') {
      return {"Muscles": this.parameter};
    } else if (this.categoryName == 'difficulty') {
      return {"Intensity_Level": this.parameter};
    } else {
      return {"Equipment": this.parameter};
    }
  }

  Future<Either<String, List<Exercise>>> getExercise() async {
    try {
      final res = await dio.get(
        exerciseAPIUrl,
        queryParameters: getParameterObj(),
        options: options,
      );

      final data = res.data as List<dynamic>;
      List<Exercise> exercises = [];

      data.forEach((exercise) {
        exercises.add(Exercise(
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
      return right(exercises);
    } catch (err) {
      return left(err.toString());
    }
  }
}
