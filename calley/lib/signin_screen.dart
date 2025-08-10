import 'dart:convert';
import 'dart:developer';

import 'package:calley/custom_widgets.dart';
import 'package:calley/home_screen.dart';
import 'package:calley/otp_screen.dart';
import 'package:calley/session_data.dart';
import 'package:calley/signup_screen.dart';
import 'package:calley/state_management.dart';
import 'package:calley/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  clearController() {
    _passwordController.clear();
    _emailController.clear();
  }

  signInUser() async {
    if (_emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty) {
      log("${SessionData.email}");
      Map<String, dynamic> userData = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      };
      try {
        Uri url = Uri.parse("https://mock-api.calleyacd.com/api/auth/login");
        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(userData),
        );

        final result = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          log("${result}");
          await SessionData.setSignInDetails(
            username: result["user"]["username"],
            userEmail: result["user"]["email"],
            id: result["user"]["_id"],
            isLogin: true,
          );
          CustomWidgets.customSnackbar(
            context: context,
            text: "Login successfully",
            color: Colors.green,
          );
          FocusScope.of(context).unfocus();

          clearController();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => VideoScreen()),
            (Route<dynamic> route) => false,
          );

          log("In if");

          log("${result}");
          log("${response.statusCode}");
        } else {
          CustomWidgets.customSnackbar(
            context: context,
            text: "Invalid  credentials",
            color: Colors.red,
          );
          log("in else");
          log("${response.body}");
          log("${response.statusCode}");
        }
      } catch (e) {
        log("$e");
      }
    } else {
      CustomWidgets.customSnackbar(
        context: context,
        text: "Please fill all the fields",
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Image.asset("assets/png/Logo.png"),
          ),

          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(color: Color.fromRGBO(203, 213, 225, 1)),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    color: Color.fromRGBO(15, 23, 42, 0.04),
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 100,
                    // ),
                    CustomWidgets.customText(
                      text: "Welcome",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),

                    CustomWidgets.customText(
                      text: "Please sign-in to continue",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(102, 102, 102, 1),
                    ),

                    SizedBox(height: 20),

                    //emailTextFormField
                    CustomWidgets.cunstomTextField(
                      text: "Email address",
                      icon: Icon(Icons.email_outlined),
                      controller: _emailController,
                    ),
                    SizedBox(height: 20),

                    //passwordTextFormField
                    CustomWidgets.cunstomTextField(
                      text: "Password",
                      icon: Icon(Icons.lock),
                      controller: _passwordController,
                    ),

                    SizedBox(height: 5),

                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "Forgot Password?",

                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   height: 100,
                    // ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  CustomWidgets.customRichText(
                    firstText: "Don’t have an account?",
                    secondText: "Sign Up",
                    fun: () {
                      FocusScope.of(context).unfocus();
                      clearController();
                      Navigator.of(context).pop();
                    },
                  ),
            
                  SizedBox(height: 10),
            
                  CustomWidgets.customElevatedButton(
                    text: "Sign In",
                    fun: () {
                      signInUser();
                    },
                    width: double.infinity,
                  ),
            
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
