import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static String? name;
  static String? email;
  static String? phoneNo;
  static String? username;
  static String? userEmail;
  static String? id;
  static bool? isLogin;

  static Future<void> setSessionData({
    required String name,
    required String email,
    required String phoneNo,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("name", name);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("phoneNo", phoneNo);

    await getSessionData();
  }

  static Future<void> setSignInDetails({
    required String username,
    required String userEmail,
    required String id,
    required bool isLogin,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("username", username);
    sharedPreferences.setString("userEmail", userEmail);
    sharedPreferences.setString("id", id);
    sharedPreferences.setBool("isLogin", isLogin);
    await getSessionData();
  }


  static Future<void> getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString("name");
    email = sharedPreferences.getString("email").toString();
    phoneNo = sharedPreferences.getString("phoneNo");
    username = sharedPreferences.getString("username");
    userEmail = sharedPreferences.getString("userEmail");
    id = sharedPreferences.getString("id");
    isLogin=sharedPreferences.getBool("isLogin");
  }
}
