import 'dart:developer';

import 'package:calley/home_screen.dart';
import 'package:calley/language_screen.dart';
import 'package:calley/session_data.dart';
import 'package:calley/state_management.dart';
import 'package:calley/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionData.getSessionData();

  log("${SessionData.email}");

  runApp(
    ChangeNotifierProvider(
      create: (context) => StateManagement(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:(SessionData.isLogin==false || SessionData.isLogin==null)?LanguageScreen():HomeScreen(),
    );
  }
}
