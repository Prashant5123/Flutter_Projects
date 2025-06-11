import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tradexa/API/imdb_api.dart';
import 'package:tradexa/Model/model_class.dart';
import 'package:tradexa/main.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    getData();

    Future.delayed(Duration(seconds: 2), () {
      getData().then((value) {
        log("Data Recived");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ));
      });
    });
  }

  Future<void> getData() async {
    List<Modelclass> data = await ApiOperation.getData("action");

    Provider.of<MyData>(context, listen: false).changeData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/images/image2.jpg"),
          ],
        ),
      ),
    );
  }
}