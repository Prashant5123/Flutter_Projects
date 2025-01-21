import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static int? articlesRead=0;
  static int? streak=0;
  static String email="";
  static bool isLogin=true;

  static storesSessionData(int streak, int articlesRead) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("articlesRead", articlesRead);
    sharedPreferences.setInt("streak", streak);
  }

  static storesUserData(int streak, int articlesRead) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", email);
    sharedPreferences.setBool("isLogin", isLogin);
  }

  static getSessionData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    articlesRead= sharedPreferences.get("articlesRead") as int;
    streak= sharedPreferences.get("streak") as int;
    isLogin=sharedPreferences.get("isLogin") as bool;
    email=sharedPreferences.get("email") as String;

  }
}
