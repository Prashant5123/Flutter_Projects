import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Getdata {

  static Future<Map> categoryData(String category)async{

    Uri url=Uri.parse( "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=581d2ff60d4946edb8d21e31c471ce9a");
    http.Response response = await http.get(url); 

    Map newsData=json.decode(response.body);

    Future.delayed(Duration(seconds: 1));

    return newsData;
 
  }

  static Future<Map> homeData()async{

    Uri url=Uri.parse( "https://newsapi.org/v2/top-headlines?country=us&apiKey=581d2ff60d4946edb8d21e31c471ce9a");
    http.Response response = await http.get(url); 

    Map newsData=json.decode(response.body);

    Future.delayed(Duration(seconds: 1));

    return newsData;
 
  }

   static Future<Map> searchData(String search)async{

    Uri url=Uri.parse( "https://newsapi.org/v2/top-headlines?q=$search&apiKey=581d2ff60d4946edb8d21e31c471ce9a");
    http.Response response = await http.get(url); 
    Map? newsData;
    if(response.statusCode==200){
      newsData=json.decode(response.body);
      log("$newsData");
    }else{
      log("data is empty");
      newsData={};
    }

    Future.delayed(Duration(seconds: 1));

    return  newsData!;
 
  }

}