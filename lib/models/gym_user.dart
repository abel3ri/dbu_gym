import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/utils/constants.dart';
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
  late String phoneNumber;
  late DateTime createdAt;
  late String affiliationStatus;
  late String monthlyFee;
  String? idImageUrl;
  String paymentStatus;
  late List<Map<String, dynamic>> paymentHistory;

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
    required this.phoneNumber,
    this.paymentStatus = 'notPaid',
    required this.paymentHistory,
    required this.createdAt,
    required this.affiliationStatus,
    required this.idImageUrl,
    required this.monthlyFee,
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
          "email": this.email,
          "gymStartDate": this.gymStartDate,
          "gymEndDate": this.gymEndDate,
          "numWorkoutDays": this.numWorkoutDays,
          "subscribedWorkoutType": this.subscribedWorkoutType,
          // "profileImageUrl": this.profileImageUrl,
          "phoneNumber": this.phoneNumber,
          "createdAt": this.createdAt,
          "paymentStatus": this.paymentStatus,
          "paymentHistory": this.paymentHistory,
          "affiliationStatus": this.affiliationStatus,
          "idImageUrl": this.idImageUrl,
          "monthlyFee": this.monthlyFee,
        });
        await user.sendEmailVerification();
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
