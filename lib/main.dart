import 'package:dbu_gym/providers/bmi_provider.dart';
import 'package:dbu_gym/providers/carousel_provider.dart';
import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:dbu_gym/providers/exercises_provider.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/home_page_grid_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/firebase_options.dart';
import 'package:dbu_gym/providers/payment_upload_provider.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/providers/theme_provider.dart';
import 'package:dbu_gym/providers/user_provider.dart';
import 'package:dbu_gym/router/router.dart';
import 'package:dbu_gym/utils/loadExercie.dart';
import 'package:dbu_gym/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:shared_preferences/shared_preferences.dart";

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // get shared preferences instance
  final prefs = await SharedPreferences.getInstance();
  // check if the app is running for the first time (i.e. key -> theme = null)
  // if so set theme to system else do nothing
  prefs.getString("theme") == null ? prefs.setString("theme", "system") : null;
  final allExercises = await loadExercises();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarouselProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => AppImageProvider()),
        ChangeNotifierProvider(create: (context) => PricingProvider()),
        ChangeNotifierProvider(create: (context) => HomePageGridProvider()),
        ChangeNotifierProvider(
          create: (context) => ExercisesProvider(allExercises: allExercises),
        ),
        ChangeNotifierProvider(create: (context) => ExerciseProvider()),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(prefs: prefs)),
        ChangeNotifierProvider(create: (context) => BMIProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PaymentUploadProvider()),
      ],
      child: Builder(builder: (context) {
        // get the current selected theme and update the theme based on user selection
        final selectedTheme =
            Provider.of<ThemeProvider>(context).getCurrentThemeMode();
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          themeMode: selectedTheme == 'system'
              ? ThemeMode.system
              : selectedTheme == 'dark'
                  ? ThemeMode.dark
                  : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      }),
    ),
  );
}
