import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/pages/home_screen.dart';
import 'package:dbu_gym/views/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.data == null) return WelcomePage();
          return HomeScreen();
        },
      ),
    );
  }
}
