import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whatbytes_todo/home_screen.dart';
import 'package:whatbytes_todo/local_data.dart';
import 'package:whatbytes_todo/login_screen.dart';
import 'package:whatbytes_todo/riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
   @override
  void initState() {
    super.initState();
    getDate();
    if(SessionData.isLogin==true){
       ref.read(riverPodHard).getFirebaseData();
    }
    
  }

  void getDate() {
    DateTime dateTime = DateTime.now();
    ref.read(riverPodHard).date = DateFormat("EEEE, dd MMMM").format(dateTime);
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
            Icon(Icons.task,
              size: 100,
              color: Colors.white,
            ),
             SizedBox(
              height: 10,
            ),
            Text(
              "TaskMaster",
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
            ),

            SizedBox(
              height: 10,
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Get started with easy task management today!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  
                    fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      nextScreen:(SessionData.isLogin==null || SessionData.isLogin==false)? LoginScreen():HomeScreen(),
    );
  }
}
