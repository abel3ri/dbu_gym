import "package:dbu_gym/utils/page_transition.dart";
import "package:dbu_gym/views/pages/contact_developer_page.dart";
import "package:dbu_gym/views/pages/exercise_details_page.dart";
import "package:dbu_gym/views/pages/exxercise_category_page.dart";
import "package:dbu_gym/views/pages/faq_page.dart";
import "package:dbu_gym/views/pages/forgot_password_page.dart";
import "package:dbu_gym/views/pages/home_page.dart";
import "package:dbu_gym/views/pages/manage_subscription_page.dart";
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
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: "/welcome",
        name: "welcome",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: WelcomePage(),
        ),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          rtl: false,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: "/signup",
        name: "signup",
        pageBuilder: (context, state) => PageTransition(
          rtl: false,
          key: state.pageKey,
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: "/home",
        name: "home",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: "/pricing",
        name: "pricing",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: PricingPage(),
        ),
      ),
      GoRoute(
        path: "/exercise-category",
        name: "exercise-category",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: ExerciseCategory(),
        ),
      ),
      GoRoute(
        path: "/exercise-details-page",
        name: "exercise-details-page",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: ExerciseDetailsPage(),
        ),
      ),
      GoRoute(
        path: "/profile",
        name: "profile",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: ProfilePage(),
        ),
      ),
      GoRoute(
        path: "/faq",
        name: "faq",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: FAQPage(),
        ),
      ),
      GoRoute(
        path: "/contact-dev",
        name: "contact-dev",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: ContactDeveloperPage(),
        ),
      ),
      GoRoute(
        path: "/payment-upload",
        name: "payment-upload",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: PaymentCheckerPage(),
        ),
      ),
      GoRoute(
        path: "/manage-subscription-page",
        name: "manage-subscription-page",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: ManageSubscriptionPage(),
        ),
      ),
      GoRoute(
        path: "/forgot-password",
        name: "forgot-password",
        pageBuilder: (context, state) => PageTransition(
          key: state.pageKey,
          child: ForgotPasswordPage(),
        ),
      ),
    ],
    errorBuilder: (context, state) => PageNotFound(),
  );
}
