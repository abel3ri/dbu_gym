import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/utils/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class GymUser {
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String gymStartDate;
  late String gymEndDate;
  late String numWorkoutDays;
  late String subscribedWorkoutType;
  late String profileImageUrl;

  GymUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gymStartDate,
    required this.gymEndDate,
    required this.numWorkoutDays,
    required this.subscribedWorkoutType,
    required this.profileImageUrl,
  });

  Future<Either<CustomError, User>> signUpUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Save user to firestore if the user is successfuly created with E&P
        await db.collection("users").doc(user.uid).set({
          "id": user.uid,
          "fullName": "${firstName} ${lastName}",
          "email": email,
          "password": password,
          "gymStartDate": gymStartDate,
          "gymEndDate": gymEndDate,
          "numWorkoutDays": numWorkoutDays,
          "subscribedWorkoutType": subscribedWorkoutType,
          "profileImageUrl": profileImageUrl,
        });
        return right(user);
      }
      ;
      return left(
        CustomError(
          errorTitle: "Authentication error",
          errorBody: "User could be not created.",
        ),
      );
    } on FirebaseAuthException catch (err) {
      return left(
        CustomError(
          errorTitle: "Authentication error.",
          errorBody: err.message!,
        ),
      );
    } catch (err) {
      return left(
        CustomError(
          errorTitle: "Error",
          errorBody: err.toString(),
        ),
      );
    }
  }

  // To Sign in user with creating an object
  static Future<Either<CustomError, User>> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) return right(user);
      return left(
        CustomError(
          errorTitle: "Authtentication error",
          errorBody: "Unable to sign in user.",
        ),
      );
    } on FirebaseAuthException catch (err) {
      if (err.message ==
          "The supplied auth credential is incorrect, malformed or has expired.")
        return left(
          CustomError(
            errorTitle: "Authentication error.",
            errorBody: "Incorrect email or password.",
          ),
        );
      else
        return left(CustomError(
            errorTitle: "Authtentication error", errorBody: err.message!));
    } catch (err) {
      return left(CustomError(errorTitle: "Error", errorBody: err.toString()));
    }
  }
}
