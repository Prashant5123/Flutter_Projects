import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobmanagement/admin_home_screen.dart';
import 'package:jobmanagement/session_data.dart';
import 'package:jobmanagement/signin_screen.dart';
import 'package:jobmanagement/state_management.dart';
import 'package:jobmanagement/user_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserDetails _userDetailsController = Get.put(UserDetails());

  @override
  void initState() {
    if (SessionData.isLogin == true) {
      _userDetailsController.email.value = SessionData.email.toString();
      _userDetailsController.firstName.value=SessionData.name.toString();
      _userDetailsController.panel.value=SessionData.panel.toString();
      _userDetailsController.lastName.value=SessionData.lastName.toString();
      if(SessionData.panel=="User"){
        _userDetailsController.getUserAllJobs();
      }else{
        _userDetailsController.getAllJobs();
      }
    }
    super.initState();
  }
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
            Icon(EvaIcons.shopping_bag, size: 100, color: Colors.white),
            SizedBox(height: 10),
            Text(
              "JobSeeker",
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Track, Manage, Succeed",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      nextScreen: (SessionData.isLogin == null || SessionData.isLogin == false)
          ? SigninScreen()
          : (SessionData.panel == "User")
          ? UserHomeScreen()
          : AdminHomeScreen(),
    );
  }
}
