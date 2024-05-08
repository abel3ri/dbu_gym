import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';

// ********************************************************** */
// ! To be included in the next update

// Future<Either<CustomError, bool>> uploadPaymentReceipt({
//   required String imageUrl,
//   required String imageName,
//   // required String userName,
// }) async {
//   try {
//     File paymentReceipt = File(imageUrl);
//     Reference ref = storage.ref().child("payment_receipts/${imageName}");
//     UploadTask uploadTask = ref.putFile(paymentReceipt);
//     final snapshot = await uploadTask.whenComplete(() => {});
//     final paymentReceiptUrl = await snapshot.ref.getDownloadURL();

//     await db.collection("users").doc(auth.currentUser!.uid).update({
//       "paymentStatus": "pending",
//       "pendingReceiptUrl": paymentReceiptUrl,
//       // "paymentHistory": FieldValue.arrayUnion([paymentReceiptUrl])
//     });
//     return right(true);
//   } on FirebaseException catch (err) {
//     return left(
//         CustomError(errorTitle: "Storage error", errorBody: err.message!));
//   } catch (err) {
//     return left(CustomError(errorTitle: "Error", errorBody: err.toString()));
//   }
// }
// ********************************************************** */

Future<Either<CustomError, String>> uploadReceiptNumber(
    {required String uid, required String receipt}) async {
  try {
    await db.collection("users").doc(uid).update(
      {
        "pendingPayments": FieldValue.arrayUnion(
          [
            {
              "date": DateTime.now(),
              "receiptNumber": receipt,
            }
          ],
        ),
        "paymentStatus": "pending",
      },
    );
    return right("Upload receipt success.");
  } on FirebaseException catch (err) {
    return left(
      CustomError(
        errorTitle: "Upload to firestore failed!",
        errorBody: err.message!,
      ),
    );
  } catch (err) {
    return left(
      CustomError(
        errorTitle: "An error has occured!",
        errorBody: err.toString(),
      ),
    );
  }
}
