import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_management/signin_screen.dart';
import 'package:job_management/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDnnW1SwDYRq_4AlqQvaw1VTJkWD44UBx0", appId: "1:933871198355:android:05a572d8182d7907dd2d66", messagingSenderId: "933871198355", projectId: "task-management-33d72"));
  runApp(const JobManagementApp());
}

class JobManagementApp extends StatelessWidget {
  const JobManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SigninScreen()
    );
  }
}
