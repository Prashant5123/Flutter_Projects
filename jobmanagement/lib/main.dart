import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobmanagement/session_data.dart';

import 'package:get/get.dart';
import 'package:jobmanagement/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCkpJfOMB_E4H61BpbXuZuL4kv6FQIGnzI",
      appId: "1:879845805604:android:e1c31b704cf8c7e702d2b1",
      messagingSenderId: "879845805604",
      projectId: "job-management-30774",
      storageBucket: "job-management-30774.firebasestorage.app",
    ),
  );
  await SessionData.getSessionData();
  runApp(const JobManagementApp());
}

class JobManagementApp extends StatelessWidget {
  const JobManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
