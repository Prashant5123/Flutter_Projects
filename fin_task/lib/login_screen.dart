import 'dart:convert';
import 'dart:developer';

import 'package:fin_task/components/textfields.dart';
import 'package:fin_task/home_screen.dart';
import 'package:fin_task/image_pick.dart';
import 'package:fin_task/register_screen.dart';
import 'package:fin_task/state_management.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AccountController accountController = Get.put(AccountController());

  void login() async {
    Uri url = Uri.parse("https://miscapi.finanalyz.com/api/Auth/login");

    var headers = {
      'accept': 'text/plain',
      'X-API-KEY': 'IIkTwlmKrKPS62C0H8XTy2zYAsBkIKim',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'POST', Uri.parse('https://miscapi.finanalyz.com/api/Auth/login'));
    request.body = json.encode({
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log("Login successful:");

      final responseBody = await response.stream.bytesToString();
      log(responseBody);
      accountController.userData = json.decode(responseBody);
      Get.off(HomeScreen());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login successful!"),
        ),
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email or password"),
        ),
      );
    } else {
      log("Login failed with status: ${response.statusCode}");
      log("Response: ${response.reasonPhrase}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Response: ${response.reasonPhrase}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("assets/png/Logo.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomWidgets.customTextField(
                    controller: emailController,
                    label: Text("Enter Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter email';
                      } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomWidgets.customTextField(
                    controller: passwordController,
                    label: Text("Enter Password"),
                    obscureText: true,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Enter password";
                      }
                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 62, 144,
                              117) //const Color.fromARGB(255, 40, 125, 73)
                          ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                         
                          Get.to(RegisterScreen());
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
