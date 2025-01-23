import 'package:flutter/material.dart';

class News extends ChangeNotifier {
  Map newsData;
 
  Map userData;

  News({required this.newsData,required this.userData});

  void changeNewsData(Map newsData){
    this.newsData=newsData;
    notifyListeners();
  }

  void changeUserData(Map userData){
    this.userData=userData;
       notifyListeners();
  }
}
