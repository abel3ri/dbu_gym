import 'dart:io';

import 'package:dbu_gym/controllers/receipt_controller.dart';
import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/providers/payment_upload_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/utils/extension.dart';
import 'package:dbu_gym/views/pages/home_page.dart';
import 'package:dbu_gym/views/pages/image_pick_selector.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import "package:easy_stepper/easy_stepper.dart";
import 'package:fpdart/fpdart.dart';
import 'package:provider/provider.dart';

class PaymentCheckerPage extends StatelessWidget {
  const PaymentCheckerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: db.collection("users").doc(auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final paymentStatus = snapshot.data!.data()!['paymentStatus'];

          if (paymentStatus == 'notPaid') {
            final imageProvider = Provider.of<ProfileImageProvider>(context);
            final paymentProvider = Provider.of<PaymentUploadProvider>(context);
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .darken(10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Debre Berhan University Athletics Club",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                Text(
                                  "ደብረ ብርሃን ዩኒቨርሲቲ አትሌቲክስ ክለብ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
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
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Required steps.",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        EasyStepper(
                          activeStep: paymentProvider.activeIndex,
                          alignment: Alignment.topLeft,
                          showLoadingAnimation: false,
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
                      ],
                    ),
                    if (imageProvider.imagePath != null) ...[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(File(imageProvider.imagePath!)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              imageProvider.imageName!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              constraints: BoxConstraints.tight(Size(
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height * 0.3)),
                              context: context,
                              builder: (context) => ImagePickSelector(),
                            );
                          },
                          child: Text("Select receipt"),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        if (imageProvider.imagePath != null)
                          ElevatedButton(
                            onPressed: () async {
                              paymentProvider.toggleIsLoading(true);
                              Either<CustomError, bool> res =
                                  await uploadPaymentReceipt(
                                imageUrl: imageProvider.imagePath!,
                                imageName: imageProvider.imageName!,
                              );
                              if (res.isLeft()) {
                                (res.asLeft as CustomError).showError(context);
                                paymentProvider.toggleIsLoading(false);
                              }
                              paymentProvider.toggleIsLoading(false);
                            },
                            child: paymentProvider.isLoading
                                ? SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text("Upload receipt"),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          if (paymentStatus == 'pending')
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
          // GoRouter.of(context).pushReplacementNamed("home");
          return HomePage();
        },
      ),
    );
  }
}
