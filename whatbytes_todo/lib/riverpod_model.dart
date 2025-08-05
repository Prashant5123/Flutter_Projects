import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatbytes_todo/local_data.dart';


class RiverpodModel extends ChangeNotifier {
  String date;
  List firebasData;
  String? name;
  RiverpodModel({required this.date, required this.firebasData,required this.name});

  void getFirebaseData() async {
    firebasData = [];
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection("user").doc(SessionData.emailId).collection("tasks").orderBy("date").get();
    for (var value in response.docs) {
      Map<String, dynamic> taskData = value.data() as Map<String, dynamic>;
      taskData["id"] = value.id;

      firebasData.add(taskData);
    }
    notifyListeners();

    log("$firebasData");
  }

 
}
