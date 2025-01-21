import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app_flutter/model/inherited_state.dart';
import 'package:news_app_flutter/view/home_screen.dart';
import 'package:news_app_flutter/view/login_page.dart';
import 'package:news_app_flutter/view/profile_screen.dart';
import 'package:news_app_flutter/view/signup_page.dart';
import 'package:news_app_flutter/view/splash_screen.dart';
import 'package:news_app_flutter/view/web_view.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCgsEQaUGIRfMlQ9tk4Nq3f3dUZEbB4q_Q", appId: "1:17235927142:android:71d2e8718fd3f656650da7", messagingSenderId: "17235927142", projectId: "ipl-team-5c68a")
  ); 
 
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
 const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // initialRoute: "/",
     
      // routes: {
      //   "/":(context)=>SplashScreen(),
      //   "login":(context)=>LoginScreen(),
      //   "signup":(context)=>SignUpScreen(),
      //   "home":(context)=>HomeScreen(),
      //   "profile":(context)=>ProfileScreen(),
      //   "webview":(context)=>WebView()
      // },
      
    );
  }
}
