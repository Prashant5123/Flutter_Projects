import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String? emailId;

  static void setSessionData(
      {required bool isLogin, required String emailId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool("isLogin", isLogin);
    sharedPreferences.setString("emailId", emailId);

    getSessionData();
  }

  static void getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    isLogin = sharedPreferences.getBool("isLogin");

    emailId=sharedPreferences.getString("emailId");
  }
}
