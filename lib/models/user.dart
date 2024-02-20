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
  late String workoutShift;

  GymUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gymStartDate,
    required this.gymEndDate,
    required this.workoutShift,
  });

  Future<Either<String, User>> signUpUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (userCredential.user != null) return right(user!);
      throw "User not created.";
    } on FirebaseAuthException catch (err) {
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
      throw "Unable to sign in user.";
    } on FirebaseAuthException catch (err) {
      return left(err.message!);
    } catch (err) {
      return left(err.toString());
    }
  }
}
