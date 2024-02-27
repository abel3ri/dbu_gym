import 'package:dbu_gym/providers/carousel_provider.dart';
import 'package:dbu_gym/providers/exercise_provider.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/home_page_grid_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/firebase_options.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/router/router.dart';
import 'package:dbu_gym/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarouselProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (context) => PricingProvider()),
        ChangeNotifierProvider(create: (context) => HomePageGridProvider()),
        ChangeNotifierProvider(create: (context) => ExerciseProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    ),
  );
}
