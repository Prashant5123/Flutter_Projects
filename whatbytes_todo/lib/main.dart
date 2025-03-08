import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatbytes_todo/home_screen.dart';
import 'package:whatbytes_todo/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDnnW1SwDYRq_4AlqQvaw1VTJkWD44UBx0", appId: "1:933871198355:android:05a572d8182d7907dd2d66", messagingSenderId: "933871198355", projectId: "task-management-33d72"));
  log("succesfully initalize");
  }catch (e){
    log("$e");
  }
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

