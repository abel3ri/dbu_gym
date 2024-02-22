import "package:dbu_gym/views/pages/home_page.dart";
import "package:dbu_gym/views/pages/pricing_page.dart";
import "package:dbu_gym/views/pages/splash_page.dart";
import "package:dbu_gym/views/pages/welcome_page.dart";
import "package:go_router/go_router.dart";
import "package:dbu_gym/views/pages/login_page.dart";
import "package:dbu_gym/views/pages/not_found_page.dart";
import 'package:dbu_gym/views/pages/sign_up_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: "splash",
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: "/welcome",
        name: "welcome",
        builder: (context, state) => WelcomePage(),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: "/signup",
        name: "signup",
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: "/home",
        name: "home",
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: "/pricing",
        name: "pricing",
        builder: (context, state) => PricingPage(),
      )
    ],
    errorBuilder: (context, state) => PageNotFound(),
  );
}
