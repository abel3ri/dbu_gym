import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/providers/payment_upload_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/pages/home_page.dart';
import 'package:dbu_gym/views/pages/image_pick_selector.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import "package:easy_stepper/easy_stepper.dart";
import 'package:provider/provider.dart';

class PaymentCheckerPage extends StatelessWidget {
  const PaymentCheckerPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Built");
    return Scaffold(
      body: StreamBuilder(
        stream: db.collection("users").doc(auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final paymentStatus = snapshot.data!.data()!['paymentStatus'];

          // print(user.firstName);
          if (paymentStatus == 'notPaid')
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .background
                                  .darken(5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Debre Berhan University Athletics Club",
                                ),
                                Text(
                                  "ደብረ ብርሃን ዩኒቨርሲቲ አትሌቲክስ ክለብ",
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Consumer<PaymentUploadProvider>(
                            builder: (context, value, child) => EasyStepper(
                              activeStep: value.activeIndex,
                              // direction: Axis.vertical,
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                // top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.05,
                              ),
                              showLoadingAnimation: false,

                              onStepReached: (index) {
                                value.setIndex(index);
                              },
                              steps: [
                                EasyStep(
                                  icon: Icon(Icons.payment),
                                  title: "Payment",
                                  finishIcon: Icon(Icons.done),
                                ),
                                EasyStep(
                                  icon: Icon(Icons.upload),
                                  title: "Receipt upload",
                                  finishIcon: Icon(Icons.done),
                                ),
                                EasyStep(
                                  icon: Icon(Icons.access_time_rounded),
                                  title: "Approval",
                                  finishIcon: Icon(Icons.done),
                                ),
                                EasyStep(
                                  icon: Icon(Icons.verified_user),
                                  title: "Done",
                                  finishIcon: Icon(Icons.done),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Consumer<ProfileImageProvider>(
                        builder: (context, value, child) => Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: value.imagePath != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        value.imagePath!,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      value.imageName!,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
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
                            child: Text("Select receipt image"),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          FilledButton(
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
                            child: Text("Upload receipt"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          if (paymentStatus == 'pending')
            return Center(
              child: Text("Payment approve pending"),
            );
          // GoRouter.of(context).pushReplacementNamed("home");
          return HomePage();
        },
      ),
    );
  }
}
