import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbu_gym/providers/user_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageSubscriptionPage extends StatelessWidget {
  const ManageSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final numOfWorkoutDays = userProvider.user!.numWorkoutDays == 'oneThree'
        ? "1-3 Days"
        : "4-6 Days";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text("Manage your subscription"),
        titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            // color: Colors.white,
            ),
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Tooltip(
            message:
                "Please refer to the gym manager if you intend to update your gym plan.",
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  height: 1.8,
                ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.darken(20),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.help),
            ),
            triggerMode: TooltipTriggerMode.tap,
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Column(
                children: [
                  CardRow(
                    title: "Affiliation status",
                    value: userProvider.user!.affiliationStatus.capitalize,
                  ),
                  CardRow(
                    title: "Subscribed workout type",
                    value: userProvider.user!.subscribedWorkoutType.capitalize,
                  ),
                  CardRow(
                    title: "Number of workout days",
                    value: numOfWorkoutDays,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "Payment history",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: userProvider.user!.paymentHistory.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.primary.darken(20),
                  elevation: 10,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      CardRow(
                        title: "Payment date",
                        titleTextStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                        value: DateFormat.yMMMd("en-US").format(
                          (userProvider.user!.paymentHistory[index]['date']
                                  as Timestamp)
                              .toDate(),
                        ),
                      ),
                      CardRow(
                        title: "Payment receipt number",
                        titleTextStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                        value: userProvider
                            .user!.paymentHistory[index]['receiptNumber']
                            .toUpperCase(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardRow extends StatelessWidget {
  CardRow({
    super.key,
    required this.title,
    required this.value,
    this.titleTextStyle,
  });

  final String title;
  final String value;
  TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: titleTextStyle),
          Chip(
            labelPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            label: SelectableText(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
