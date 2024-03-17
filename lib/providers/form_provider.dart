import 'dart:io';

import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class FormProvider with ChangeNotifier {
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isAuthenticating = false;
  bool _hasDateInputError = false;
  String _dateInputErrorStr = '';
  String _selectedWorkoutDays = 'default';
  String? _preferedWorkoutType;
  String? _profileImageUrl;
  bool _hasPassRepassInputError = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void toggleDateInputError() {
    _hasDateInputError = true;
    notifyListeners();
  }

  void toggleDateInputSuccess() {
    _hasDateInputError = false;
    notifyListeners();
  }

  void setIsAuthtentcating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  void setSelectedWorkoutDays(String value) {
    _selectedWorkoutDays = value;
    notifyListeners();
  }

  void setPreferedWorkoutType(String value) {
    _preferedWorkoutType = value;
    notifyListeners();
  }

  void setDateInputStr(String errorName) {
    _dateInputErrorStr = errorName;
    notifyListeners();
  }

  void sethasPassRepassInputError(bool value) {
    _hasPassRepassInputError = value;
    notifyListeners();
  }

  Future<Either<CustomError, String>> setProfileImageUrl(
      String imageUrl, String imageName) async {
    try {
      File profileImage = File(imageUrl);
      Reference ref = storage.ref().child("profile_images/${imageName}");
      UploadTask uploadTask = ref.putFile(profileImage);
      final snapshot = await uploadTask.whenComplete(() => {});
      _profileImageUrl = await snapshot.ref.getDownloadURL();
      notifyListeners();
      return right(_profileImageUrl!);
    } on FirebaseException catch (err) {
      return left(
          CustomError(errorTitle: "Storage error", errorBody: err.message!));
    } catch (err) {
      return left(CustomError(errorTitle: "Error", errorBody: err.toString()));
    }
  }

  bool get showPassword => _showPassword;
  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;
  bool get hasDateInputError => _hasDateInputError;
  bool get isAuthenticating => _isAuthenticating;
  String get selectedWorkoutDays => _selectedWorkoutDays;
  String get preferedWorkoutType => _preferedWorkoutType!;
  String get profileImageUrl => _profileImageUrl!;
  String? get dateInputErrorStr => _dateInputErrorStr;
  bool get hasPassRepassInputError => _hasPassRepassInputError;
}
