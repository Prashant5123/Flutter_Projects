import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_flutter/controller/local_storage.dart';
import 'package:news_app_flutter/model/inherited_state.dart';
import 'package:news_app_flutter/view/home_screen.dart';
import 'package:http/io_client.dart';
import 'package:news_app_flutter/view/login_page.dart';

Map newsData = {};
String date = "";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat("EEE d MMMM, yyyy").format(now);

     LocalStorage.getSessionData();
    
    getData();
   
   
    Future.delayed(
        Duration(seconds: 3),
      
            );
  }

  void getData() async {
    try {
      
      Uri url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=581d2ff60d4946edb8d21e31c471ce9a");
      http.Response response = await http.get(url);
      newsData = await json.decode(response.body);
    } catch (er) {
      log("error");
      log(er.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
          splash: Image.asset("assets/image.png"),
          splashIconSize: 130,
          duration: 3000,
          nextScreen:LoginScreen());
  }
}






