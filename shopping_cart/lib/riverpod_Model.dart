import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RiverpodModel extends ChangeNotifier {
  Map products;
  List cart;
  int count;
  num totalPrice;
  num productCount;
  RiverpodModel(
      {required this.products, required this.cart, required this.count,required this.totalPrice,required this.productCount});

  void getData() async {
    Uri url = Uri.parse("https://dummyjson.com/products");
    http.Response response = await http.get(url);

    products = json.decode(response.body);
  }

  Widget discount(int index) {
    num discountPer = products["products"][index]["discountPercentage"];
    num price = products["products"][index]["price"];
    num discountPrice = price - (price * (discountPer / 100));
  
    products["products"][index]["discountPrice"]=discountPrice;
    
    String actualPrice = discountPrice.toStringAsFixed(2);
    return Text("$actualPrice");
  }
  //increment
  void addProduct(int index) {
    count = cart[index]["productCount"];
    count++;
    cart[index]["productCount"] = count;

    notifyListeners();
  }
  //decrement
  void deleteProduct(int index) {
    count = cart[index]["productCount"];

    if (count > 1) {
      count--;
      cart[index]["productCount"] = count;
    }

    notifyListeners();
  }

  void countTotalPrice(){
    totalPrice=0;
    productCount=0;
    for(int i=0;i<cart.length;i++){
      totalPrice=totalPrice + cart[i]["productCount"]*cart[i]["discountPrice"];
      productCount=productCount+cart[i]["productCount"];
    }
  }
}
