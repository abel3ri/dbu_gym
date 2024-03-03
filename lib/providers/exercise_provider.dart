import 'dart:io';

import 'package:dbu_gym/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import "dart:typed_data";

import 'package:image/image.dart' as img;
import "package:dio/dio.dart";

class ExerciseProvider with ChangeNotifier {
  Exercise? _exercise;
  bool _isLoading = false;

  void setExercise(Exercise exercise) {
    if (_exercise != null) _exercise = null;
    _exercise = exercise;
    notifyListeners();
  }

  Future<Either<String, List<int>?>> convertJpgToPdf() async {
    try {
      List<int> _gifBytes = [];
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
      return right(_gifBytes);
    } on SocketException catch (_) {
      return left("Connection time out.");
    } catch (err) {
      print(err.toString());
      return left(err.toString());
    }
  }

  Exercise? get exercise => _exercise!;
  bool get isLoadig => _isLoading;
}
