import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Future<void> signUpLoginController({
  required FormProvider formProvider,
  required BuildContext context,
  required formType,
}) async {
  dynamic res;
  Provider.of<FormProvider>(context, listen: false).setIsAuthtentcating(true);

  try {
    if (formType == "Sign up") {
      GymUser user = GymUser(
        firstName: formProvider.firstNameController.text,
        lastName: formProvider.lastNameController.text,
        email: formProvider.emailController.text,
        password: formProvider.passwordController.text,
        gymStartDate: formProvider.startDateController.text,
        gymEndDate: formProvider.endDateController.text,
        workoutSession: formProvider.workoutSession!,
      );
      res = await user.signUpUserWithEmailAndPassword();
    } else
      res = await GymUser.signInUserWithEmailAndPassword(
        email: formProvider.emailController.text,
        password: formProvider.passwordController.text,
      );
  } catch (err) {
    print(err.toString());
  }

  Provider.of<FormProvider>(context, listen: false).setIsAuthtentcating(false);
  res.fold((errorMessage) {
    // print(errorMessage);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
            label: "Close",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
        content: Text(errorMessage),
      ),
    );
  }, (user) {
    GoRouter.of(context).pushReplacementNamed("home");
  });
}
