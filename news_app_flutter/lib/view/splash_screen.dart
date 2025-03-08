
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';


import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_flutter/controller/local_storage.dart';

import 'package:news_app_flutter/view/login_page.dart';
import 'package:provider/provider.dart';

import '../model/news.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime now = DateTime.now();

  @override
  void initState() {
 
    super.initState();
    

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
      Map newsData = await json.decode(response.body);
      // ignore: use_build_context_synchronously
      Provider.of<News>(context,listen: false).changeNewsData(newsData) ;
    } catch (er) {
    
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






