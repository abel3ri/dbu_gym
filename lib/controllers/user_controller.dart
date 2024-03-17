import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/utils/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

Future<Either<CustomError, String>> signUpController({
  required GymUser user,
}) async {
  Either<CustomError, User> res;
  try {
    res = await user.signUpUserWithEmailAndPassword();

    if (res.isLeft()) {
      return left(
        CustomError(
          errorTitle: (res.asLeft as CustomError).errorTitle,
          errorBody: (res.asLeft as CustomError).errorBody,
        ),
      );
    } else {
      return right("Success.");
    }
  } on FirebaseAuthException catch (err) {
    return left(
      CustomError(errorTitle: "Authentication error", errorBody: err.message!),
    );
  } catch (err) {
    return left(
      CustomError(
        errorTitle: "Authentication error",
        errorBody: err.toString(),
      ),
    );
  }
}

Future<Either<CustomError, String>> loginController({
  required String email,
  required String password,
}) async {
  try {
    Either<CustomError, User> res;
    // Login controller
    res = await GymUser.signInUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (res.isLeft()) {
      return left(
        CustomError(
          errorTitle: (res.asLeft as CustomError).errorTitle,
          errorBody: (res.asLeft as CustomError).errorBody,
        ),
      );
    } else {
      return right("Success.");
    }
  } catch (err) {
    return left(
      CustomError(
        errorTitle: "Authentication error",
        errorBody: err.toString(),
      ),
    );
  }
}

Future<Either<CustomError, GymUser>> getUserData() async {
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
      phoneNumber: userData['phoneNumber'],
      createdAt: DateTime.now(),
      paymentHistory: [],
      hasPaid: userData['hasPaid'],
    );
    return right(user);
  } on FirebaseException catch (err) {
    return left(
      CustomError(errorTitle: "Fetching err", errorBody: err.message!),
    );
  } catch (err) {
    return left(
      CustomError(
        errorTitle: "Fetching error",
        errorBody: err.toString(),
      ),
    );
  }
}
