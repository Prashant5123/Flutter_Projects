import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class AccountController extends GetxController {
  RxString accountType = "Savings".obs;
  RxList<String> accountNumbers = <String>[].obs;
  RxString userId = "".obs;
  Map userData = {};
  

  void changeAccount(String newAccountType) {
    accountType.value = newAccountType;
  }

  void getSavingAccountNumbers(String accountType) async {
    var headers = {
      'accept': 'text/plain',
      'X-API-KEY': 'IIkTwlmKrKPS62C0H8XTy2zYAsBkIKim',
      'Content-Type': 'application/json'
    };

    log(userData["id"]);

    var request = http.Request('POST',
        Uri.parse('https://miscapi.finanalyz.com/api/Auth/get-accounts'));
    request.body =
        json.encode({"accountType": accountType, "userId": userData["id"]});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
        accountNumbers.clear();
      
      final data = json.decode(responseBody);
      List<String> dummy=[];
      for (int i = 0; i < data.length; i++) {
        dummy.add(data[i]["accountDetails"]);
        //dummy.add("${i+1})${ data[i]["accountDetails"]}");
      }



      accountNumbers.assignAll(dummy.toSet().toList()); 


      log("$accountNumbers");
    } else {
      print(response.reasonPhrase);
    }
  }
}
