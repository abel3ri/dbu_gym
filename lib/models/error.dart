import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomError {
  String errorTitle;
  String errorBody;
  CustomError({
    required this.errorTitle,
    required this.errorBody,
  });
  void showError(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 10),
        content: AwesomeSnackbarContent(
          title: errorTitle,
          message: errorBody,
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
