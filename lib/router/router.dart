import "package:go_router/go_router.dart";
import "package:dbu_gym/views/pages/login_page.dart";
import "package:dbu_gym/views/pages/not_found_page.dart";
import "package:dbu_gym/views/pages/welcome_page.dart";
import 'package:dbu_gym/views/pages/sign_up_page.dart';
import 'package:dbu_gym/views/pages/sign_up_intermediate_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
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
        path: "/signup-intermediate",
        name: "signup-intermediate",
        builder: (context, state) => SignUpIntermediatePage(),
      ),
    ],
    errorBuilder: (context, state) => PageNotFound(),
  );
}
