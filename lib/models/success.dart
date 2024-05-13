import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SuccessMessage {
  String successTitle;
  String successBody;
  SuccessMessage({
    required this.successTitle,
    required this.successBody,
  });
  void showSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: AwesomeSnackbarContent(
          title: successTitle,
          message: successBody,
          contentType: ContentType.success,
        ),
      ),
    );
  }
}
