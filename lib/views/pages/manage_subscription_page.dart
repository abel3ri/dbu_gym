import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageSubscriptionPage extends StatelessWidget {
  const ManageSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
