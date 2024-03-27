import 'package:dbu_gym/models/error.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:fpdart/fpdart.dart';

Future<Either<CustomError, List>> loadExercises() async {
  try {
    final res = await rootBundle.loadString("assets/exercises/exercises.json");
    final data = await json.decode(res);
    return right(data);
  } catch (err) {
    return left(CustomError(
        errorTitle: "Error", errorBody: "error loading exercises."));
  }
}
