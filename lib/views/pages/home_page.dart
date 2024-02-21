import 'package:dbu_gym/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello there!"),
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();
                GoRouter.of(context).pushReplacementNamed("splash");
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
