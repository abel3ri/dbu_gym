import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void clearFormInputs(BuildContext context) {
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  formProvider.setSelectedWorkoutDays("default");
  Provider.of<AppImageProvider>(context, listen: false)
      .setImagePathAndName(null, null);

  Provider.of<AppImageProvider>(context, listen: false)
      .setIdImagePathAndName(null, null);
  formProvider.toggleDateInputSuccess();
  formProvider.setDateInputStr("");
}
