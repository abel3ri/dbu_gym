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
  String? _affiliationStatusError;
  String _dateInputErrorStr = '';
  String _selectedWorkoutDays = 'default';
  String? _preferedWorkoutType;
  bool _hasPassRepassInputError = false;
  String _affiliationStatus = 'default';
  String? _selectedImagePicker;
  String? _profileImageUrl;
  String? _idImageUrl;
  String? _totalFeeAmount;
  String? _formType;

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

  void setAffiliationStatus(String value) {
    _affiliationStatus = value;
    notifyListeners();
  }

  void setSelectedImagePicker(String value) {
    _selectedImagePicker = value;
    notifyListeners();
  }

  void setAffiliationStatusError(String? errorMessage) {
    _affiliationStatusError = errorMessage;
    notifyListeners();
  }

  void setFormType(String formType) {
    _formType = formType;
    notifyListeners();
  }

  Future<Either<CustomError, String>> uploadProfileImage(
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

  Future<Either<CustomError, String>> uploadIdImage(
      String imageUrl, String imageName) async {
    try {
      File idImage = File(imageUrl);
      Reference ref = storage.ref().child("insider_id/${imageName}");
      UploadTask uploadTask = ref.putFile(idImage);
      final snapshot = await uploadTask.whenComplete(() => {});
      _idImageUrl = await snapshot.ref.getDownloadURL();

      notifyListeners();
      return right(_idImageUrl!);
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
  String get affiliationStatus => _affiliationStatus;
  String? get selectImagePicker => _selectedImagePicker;
  String? get affiliationStatusError => _affiliationStatusError;
  String? get idImageUrl => _idImageUrl;
  String? get totalFeeAmount => _totalFeeAmount;
  String? get formType => _formType;
}
