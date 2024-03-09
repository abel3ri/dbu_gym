import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
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
        numWorkoutDays: formProvider.selectedWorkoutDays,
        subscribedWorkoutType: formProvider.preferedWorkoutType,
        profileImageUrl: formProvider.profileImageUrl,
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
    GoRouter.of(context).pushReplacementNamed("splash");
  });
}

Future<GymUser?> getUserData() async {
  try {
    final res = await db.collection("users").doc(auth.currentUser!.uid).get();
    Map<String, dynamic> userData = res.data()!;
    GymUser user = GymUser(
      firstName: userData['fullName'].split(" ")[0],
      lastName: userData['fullName'].split(" ")[1],
      email: userData['email'],
      password: userData['password'],
      gymStartDate: userData['gymStartDate'],
      gymEndDate: userData['gymEndDate'],
      numWorkoutDays: userData['numWorkoutDays'],
      subscribedWorkoutType: userData['subscribedWorkoutType'],
      profileImageUrl: userData['profileImageUrl'],
    );
    return user;
  } catch (err) {
    print(err.toString());
  }
  return null;
}
