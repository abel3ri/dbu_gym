import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Page Not Found"),
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).canPop()
                  ? GoRouter.of(context).pop()
                  : GoRouter.of(context).pushReplacementNamed("welcome");
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "404",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            SizedBox(height: 10),
            Text(
              "The Page You're Requesting Could Not Be Found!",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacementNamed("welcome");
                },
                child: Text("Go back to home"))
          ],
        ),
      ),
    );
  }
}
