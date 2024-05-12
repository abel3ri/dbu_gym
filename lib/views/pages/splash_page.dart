import 'package:dbu_gym/controllers/user_controller.dart';
import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/providers/user_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/utils/get_pricing_data.dart';
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
  void didChangeDependencies() {
    /// load user data only if there is an authenticated user and the user -> UserProvider is null (if user -> UserPovider is not null ? userdata is already loadded)
    if (auth.currentUser != null &&
        Provider.of<UserProvider>(context).user == null)
      getUserData().then((Either<CustomError, GymUser> value) {
        value.fold((error) {
          error.showError(context);
        }, (user) {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          setState(() {});
        });
      });

    /// get dynamic price data instead of hard coded one that may change overtime
    /// send get request only if the current price data is null
    if (Provider.of<PricingProvider>(context, listen: false).priceData == null)
      getPricingContent().then((value) {
        value.fold((err) {
          err.showError(context);
        }, (workoutPriceData) {
          Provider.of<PricingProvider>(context, listen: false)
              .setPriceData(workoutPriceData);
          setState(() {});
        });
      });
    super.didChangeDependencies();
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
          if (snapshot.hasError) {
            return Center(child: Text("Connection problem"));
          }
          if (snapshot.data == null) return WelcomePage();
          return PaymentCheckerPage();
        },
      ),
    );
  }
}
