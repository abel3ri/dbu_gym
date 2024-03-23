import 'package:dbu_gym/controllers/user_controller.dart';
import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/user_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/pages/payment_checker_page.dart';
import 'package:dbu_gym/views/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    if (auth.currentUser != null)
      getUserData().then((Either<CustomError, GymUser> value) {
        value.fold((error) {
          error.showError(context);
        }, (user) {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          setState(() {});
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<UserProvider>(context).user);
    return Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.data == null) return WelcomePage();
          return PaymentCheckerPage();
        },
      ),
    );
  }
}
