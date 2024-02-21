import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> signUpLoginController(
    FormProvider formProvider, BuildContext context) async {
  GymUser user = GymUser(
    firstName: formProvider.firstNameController.text,
    lastName: formProvider.lastNameController.text,
    email: formProvider.emailController.text,
    password: formProvider.passwordController.text,
    gymStartDate: formProvider.startDateController.text,
    gymEndDate: formProvider.endDateController.text,
    workoutSession: formProvider.workoutSession!,
  );

  final res = await user.signUpUserWithEmailAndPassword();
  Provider.of<FormProvider>(context, listen: false).setIsAuthtentcating(false);
  // Display error logic here

  res.fold((l) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
            label: "Close",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
        content: Text(l),
      ),
    );
  }, (r) {});
}
