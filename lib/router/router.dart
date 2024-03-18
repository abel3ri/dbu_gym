import "package:dbu_gym/views/pages/contact_developer_page.dart";
import "package:dbu_gym/views/pages/exercise_details_page.dart";
import "package:dbu_gym/views/pages/exxercise_category_page.dart";
import "package:dbu_gym/views/pages/faq_page.dart";
import "package:dbu_gym/views/pages/home_page.dart";
import "package:dbu_gym/views/pages/pricing_page.dart";
import "package:dbu_gym/views/pages/profile_page.dart";
import "package:dbu_gym/views/pages/splash_page.dart";
import "package:dbu_gym/views/pages/welcome_page.dart";
import "package:go_router/go_router.dart";
import "package:dbu_gym/views/pages/login_page.dart";
import "package:dbu_gym/views/pages/not_found_page.dart";
import 'package:dbu_gym/views/pages/sign_up_page.dart';
import 'package:dbu_gym/views/pages/payment_checker_page.dart';

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
      ),
      GoRoute(
        path: "/exercise-category",
        name: "exercise-category",
        builder: (context, state) => ExerciseCategory(),
      ),
      GoRoute(
        path: "/exercise-details-page",
        name: "exercise-details-page",
        builder: (context, state) => ExerciseDetailsPage(),
      ),
      GoRoute(
        path: "/profile",
        name: "profile",
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: "/faq",
        name: "faq",
        builder: (context, state) => FAQPage(),
      ),
      GoRoute(
        path: "/contact-dev",
        name: "contact-dev",
        builder: (context, state) => ContactDeveloperPage(),
      ),
      GoRoute(
        path: "/payment-upload",
        name: "payment-upload",
        builder: (context, state) => PaymentCheckerPage(),
      ),
    ],
    errorBuilder: (context, state) => PageNotFound(),
  );
}
