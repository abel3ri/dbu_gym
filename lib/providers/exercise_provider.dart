import 'package:dbu_gym/models/exercise.dart';
import 'package:flutter/material.dart';
import "dart:typed_data";

import 'package:image/image.dart' as img;
import "package:dio/dio.dart";

class ExerciseProvider with ChangeNotifier {
  Exercise? _exercise;
  bool _isLoading = false;
  List<int> _gifBytes = [];

  void setExercise(Exercise exercise) {
    if (_exercise != null) _exercise = null;
    _exercise = exercise;
    notifyListeners();
  }

  Future<void> convertJpgToPdf() async {
    try {
      List<String> imagePaths = exercise!.images
          .map((e) =>
              "https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/${e}")
          .toList();
      _isLoading = true;
      img.Animation animation = img.Animation();
      Dio dio = Dio();
      for (String imagePath in imagePaths) {
        Response<List<int>> res = await dio.get(imagePath,
            options: Options(
              responseType: ResponseType.bytes,
            ));
        List<int> bytes = res.data!;
        img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
        image.duration = 500;
        animation.addFrame(image);
      }

      _gifBytes = img.encodeGifAnimation(animation)!;
      _isLoading = false;
      notifyListeners();
    } catch (err) {
      print(err.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Exercise? get exercise => _exercise!;
  List<int> get gifBytes => _gifBytes;
  bool get isLoadig => _isLoading;
}
