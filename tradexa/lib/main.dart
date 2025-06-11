import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradexa/Model/model_class.dart';
import 'package:tradexa/View/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return MyData(list: []);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
class MyData extends ChangeNotifier {
  List<Modelclass> list;

  MyData({required this.list});

  void changeData(List<Modelclass> list) {
    this.list = list;
    notifyListeners();
  }
}