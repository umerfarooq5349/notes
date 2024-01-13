// ignore: file_names
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/UI/auth/login.dart';
import 'package:notes/UI/home_screen.dart';
import 'package:notes/styles/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      if (auth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Colors.orange,
              child: const Image(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/img.jpg')),
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Complete the stoRy with yOUr deeds',
                  style: AppStyle.appBar,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
