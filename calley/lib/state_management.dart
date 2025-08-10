import 'dart:convert';
import 'dart:developer';

import 'package:calley/session_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StateManagement extends ChangeNotifier {
  Map<String, dynamic> result = {};
  Future<void> getUserData() async {
    log("${SessionData.id}");
    Uri url = Uri.parse(
      "https://mock-api.calleyacd.com/api/list/68626fb697757cb741f449b9",
    );

    http.Response response = await http.get(url);

    result = jsonDecode(response.body);

    log("$result");

    notifyListeners();
  }
}
