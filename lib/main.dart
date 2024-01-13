import 'package:flutter/material.dart';
// import 'package:notes/UI/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:notes/styles/splash_Screen.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(color: AppStyle.whiteColor),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppStyle.purpule,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppStyle.purpule),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
