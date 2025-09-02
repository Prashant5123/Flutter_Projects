
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobmanagement/signin_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splashIconSize: 400,
      backgroundColor: const Color.fromARGB(255, 91, 85, 243),
      splash: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(EvaIcons.shopping_bag,
              size: 100,
              color: Colors.white,
            ),
             SizedBox(
              height: 10,
            ),
            Text(
              "JobSeeker",
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
            ),

            SizedBox(
              height: 10,
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Track, Manage, Succeed",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  
                    fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      nextScreen:SigninScreen(),
    );
  }
}
