import 'dart:convert';

import 'package:crypto/crypto.dart';
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
  late String workoutSession;

  GymUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gymStartDate,
    required this.gymEndDate,
    required this.workoutSession,
  });

  Future<Either<String, User>> signUpUserWithEmailAndPassword() async {
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
          "fullName": firstName + lastName,
          "email": email,
          "password": hashPassword(password),
          "gymStartDate": gymStartDate,
          "gymEndDate": gymEndDate,
          "workoutSession": workoutSession,
        });
        return right(user);
      }
      ;
      return left("User not created.");
    } on FirebaseAuthException catch (err) {
      if (err.message ==
          "The email address is already in use by another account.")
        return left("E-mail already in use.");

      return left(err.message!);
    } catch (err) {
      return left(err.toString());
    }
  }

  Future<Either<String, User>> signInUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (userCredential.user != null) return right(user!);
      return left("Unable to sign in user.");
    } on FirebaseAuthException catch (err) {
      if (err.message ==
          "The email address is already in use by another account.")
        return left("E-mail already in use.");

      return left(err.message!);
    } catch (err) {
      return left(err.toString());
    }
  }

  // hash password before storing to db
  String hashPassword(String password) {
    return sha1.convert(utf8.encode(password)).toString();
  }
}
