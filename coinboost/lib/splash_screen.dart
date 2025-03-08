import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coinboost/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 190,
                width: 190,
                child: Image.asset("assets/png/boost_logo.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "COINBOOST",
                style: GoogleFonts.robotoMono(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(247, 147, 26, 1),
                ),
              )
            ],
          ),
          splashIconSize: 400,
          duration: 3000,
          nextScreen: OnboardingScreen()),
    );
  }
}
