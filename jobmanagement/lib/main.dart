import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobmanagement/signin_screen.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCkpJfOMB_E4H61BpbXuZuL4kv6FQIGnzI", appId: "1:879845805604:android:e1c31b704cf8c7e702d2b1", messagingSenderId: "879845805604", projectId: "job-management-30774"));
  runApp(const JobManagementApp());
}

class JobManagementApp extends StatelessWidget {
  const JobManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SigninScreen()
    );
  }
}
