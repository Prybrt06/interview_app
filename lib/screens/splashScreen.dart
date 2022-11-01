import 'package:flutter/material.dart';
import 'package:interview/screens/homePage.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/json/interviewAnimation.json'),
      splashIconSize: 300,
      nextScreen: HomePage(),
    );
  }
}