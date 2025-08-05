import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fin_task/camera/first_screen.dart';
import 'package:fin_task/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: AnimatedSplashScreen(
//         duration: 3000,
//         splashIconSize: 200,
//           splash: Image.asset("assets/png/Logo.png"),
//           nextScreen: LoginScreen(),),
//       debugShowCheckedModeBanner: false,

//     );
//   }
// }
