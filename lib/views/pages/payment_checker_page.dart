import 'dart:io';

import 'package:dbu_gym/controllers/receipt_controller.dart';
import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/providers/payment_upload_provider.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/providers/user_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/pages/home_page.dart';
import 'package:dbu_gym/views/widgets/payment_page_card.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import "package:easy_stepper/easy_stepper.dart";
import 'package:provider/provider.dart';

class PaymentCheckerPage extends StatelessWidget {
  const PaymentCheckerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentUploadProvider>(context);
    final priceProvider = Provider.of<PricingProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final formKey = GlobalKey<FormState>();
    String? priceType;
    String? selectedWorkoutDays;
    String? price;
    String? selectedWorkoutType;
    if (userProvider.user != null) {
      priceType = userProvider.user!.affiliationStatus == 'insider'
          ? 'insidersPrice'
          : "outsidersPrice";
      selectedWorkoutType = userProvider.user!.subscribedWorkoutType.capitalize;

      selectedWorkoutDays = userProvider.user!.numWorkoutDays == 'oneThree'
          ? "1-3 Days / Week"
          : "4-6 Days / Week";

      // get price based on selected workout days, selected plan type
      price = priceProvider.priceData != null
          ? userProvider.user!.numWorkoutDays == 'oneThree'
              ? List.from(priceProvider.priceData![0]['1-3Days'])
                  .where(
                    (e) =>
                        e["workoutType"] ==
                        userProvider.user!.subscribedWorkoutType,
                  )
                  .toList()[0][priceType]
              : List.from(priceProvider.priceData![1]['4-6Days'])
                  .where(
                    (e) =>
                        e["workoutType"] ==
                        userProvider.user!.subscribedWorkoutType,
                  )
                  .toList()[0][priceType]
          : "Loading...";
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // *********************************************************** */
          // ! To be included in the next update
          // formProvider.setSelectedImagePicker("receiptPicture");
          // *********************************************************** */
          showModalBottomSheet(
            showDragHandle: true,

            isScrollControlled: true,
            // useSafeArea: true,
            // constraints: BoxConstraints.expand(),
            context: context,
            // ************************************ */
            // ! To be included in the next update
            // builder: (context) => ImagePickSelector(),
            // ************************************ */
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          fillColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(50),
                          labelText: "Enter receipt number",
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please provide receipt number";
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FilledButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                        child: Text("Submit"),
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(40)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        label: Text("Add receipt number"),
        // shape: CircleBorder(),
      ),
      body: StreamBuilder(
        stream: db.collection("users").doc(auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasError) {
            CustomError(errorTitle: "Error", errorBody: "Connection Problem")
                .showError(context);
          }
          final paymentStatus = snapshot.data!.data()!['paymentStatus'];

          if (paymentStatus == 'notPaid') {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,
                ),
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: PaymentPageCard(
                            children: [
                              Text(
                                "Debre Berhan University Athletics Club"
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.white,
                                ),
                              ),
                              Text(
                                "ደብረ ብርሃን ዩኒቨርሲቲ አትሌቲክስ ክለብ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "1000025359279",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                          // color: Colors.white,
                                        ),
                                  ),
                                  Image.asset(
                                    "assets/images/cbe_logo.png",
                                    width: 48,
                                    height: 48,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          "Required steps",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        EasyStepper(
                          activeStep: paymentProvider.activeIndex,
                          alignment: Alignment.topLeft,
                          unreachedStepIconColor:
                              Theme.of(context).colorScheme.primary,
                          unreachedStepTextColor:
                              Theme.of(context).colorScheme.primary,
                          showLoadingAnimation: false,
                          enableStepTapping: false,
                          onStepReached: (index) {
                            paymentProvider.setIndex(index);
                          },
                          internalPadding: 48,
                          steps: [
                            EasyStep(
                              icon: Icon(Icons.payment),
                              title: "Make payment",
                              finishIcon: Icon(Icons.done),
                            ),
                            EasyStep(
                              icon: Icon(Icons.upload),
                              title: "Upload receipt",
                              finishIcon: Icon(Icons.done),
                            ),
                            EasyStep(
                              icon: Icon(Icons.access_time_rounded),
                              title: "Wait for Approval",
                              finishIcon: Icon(Icons.done),
                            ),
                            EasyStep(
                              icon: Icon(Icons.verified_user),
                              title: "Done",
                              finishIcon: Icon(Icons.done),
                            ),
                          ],
                        ),
                        PaymentPageCard(
                          children: [
                            Text(
                              "Your payment details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            PaymentDetailsRow(
                              title: "Selected workout plan type",
                              value: selectedWorkoutType ?? "Loading...",
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            PaymentDetailsRow(
                              title: "Selected workout days",
                              value: selectedWorkoutDays ?? "Loading...",
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            PaymentDetailsRow(
                              title: "Total Fee",
                              value: price ?? "Loading...",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                    // ************************************************************ */
                    /// ! To be inlcuded in the next update
                    // if (imageProvider.receiptImagePath != null) ...[
                    //   Container(
                    //     width: MediaQuery.of(context).size.width * 0.95,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         ClipRRect(
                    //           borderRadius: BorderRadius.circular(8),
                    //           child: Image.file(
                    //             File(imageProvider.receiptImagePath!),
                    //           ),
                    //         ),
                    //         SizedBox(height: 8),
                    //         Text(
                    //           imageProvider.receiptImageName!,
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   SizedBox(
                    //       height: MediaQuery.of(context).size.height * 0.05),
                    // ],
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.02),
                    //     if (imageProvider.receiptImagePath != null)
                    //       ElevatedButton(
                    //         onPressed: () async {
                    //           paymentProvider.toggleIsLoading(true);
                    //           Either<CustomError, bool> res =
                    //               await uploadPaymentReceipt(
                    //             imageUrl: imageProvider.receiptImagePath!,
                    //             imageName: imageProvider.receiptImageName!,
                    //           );
                    //           res.fold(
                    //             (err) {
                    //               err.showError(context);
                    //             },
                    //             (r) {
                    //               clearFormInputs(context);
                    //             },
                    //           );
                    //           paymentProvider.toggleIsLoading(false);
                    //         },
                    //         child: paymentProvider.isLoading
                    //             ? SizedBox(
                    //                 height: 16,
                    //                 width: 16,
                    //                 child: CircularProgressIndicator(
                    //                   strokeWidth: 2,
                    //                 ),
                    //               )
                    //             : Text("Upload receipt"),
                    //       ),
                    //   ],
                    // ),
                    // ******************************************************** */
                  ],
                ),
              ),
            );
          }
          if (paymentStatus == 'pending') {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_top_rounded, size: 72),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Please be patient till your payment is approved.",
                    ),
                  ],
                ),
              ),
            );
          }

          return HomePage();
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class PaymentDetailsRow extends StatelessWidget {
  String title;
  String value;
  PaymentDetailsRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}
