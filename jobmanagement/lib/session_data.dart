import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static String? email;
  static bool? isLogin;
  static String? panel;
  static String? name;
   static String? lastName;
  static List? previousJobs;

  static Future setSessionData({
    required String email,
    required bool isLogin,
    required String panel,
     required String name,
      required String lastName,

  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool("isLogin", isLogin);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("panel", panel);
     sharedPreferences.setString("name", name);
     sharedPreferences.setString("lastName", lastName);
    await getSessionData();
  }

  static Future getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    name = sharedPreferences.getString("name");
     lastName = sharedPreferences.getString("lastName");
    email = sharedPreferences.getString("email");
    panel = sharedPreferences.getString("panel");
    isLogin = sharedPreferences.getBool("isLogin");

  }

  
}
