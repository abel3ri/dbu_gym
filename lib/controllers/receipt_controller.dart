import 'dart:io';

import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';

Future<Either<CustomError, bool>> uploadPaymentReceipt({
  required String imageUrl,
  required String imageName,
  // required String userName,
}) async {
  try {
    File paymentReceipt = File(imageUrl);
    Reference ref = storage.ref().child("payment_receipts/${imageName}");
    UploadTask uploadTask = ref.putFile(paymentReceipt);
    final snapshot = await uploadTask.whenComplete(() => {});
    final paymentReceiptUrl = await snapshot.ref.getDownloadURL();

    await db.collection("users").doc(auth.currentUser!.uid).update({
      "paymentStatus": "pending",
      "pendingReceiptUrl": paymentReceiptUrl,
      // "paymentHistory": FieldValue.arrayUnion([paymentReceiptUrl])
    });
    return right(true);
  } on FirebaseException catch (err) {
    return left(
        CustomError(errorTitle: "Storage error", errorBody: err.message!));
  } catch (err) {
    return left(CustomError(errorTitle: "Error", errorBody: err.toString()));
  }
}
