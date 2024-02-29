import 'package:flutter/services.dart';
import 'dart:convert';

Future<List> loadExercises() async {
  final res = await rootBundle.loadString("assets/exercises/exercises.json");
  final data = await json.decode(res);
  return data;
}
