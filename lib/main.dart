import 'package:dbu_gym/providers/carousel_provider.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/firebase_options.dart';
import 'package:dbu_gym/router/router.dart';
import 'package:dbu_gym/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarouselProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => AppImageProvider()),
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
