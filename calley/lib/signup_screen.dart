import 'dart:convert';
import 'dart:developer';

import 'package:calley/custom_widgets.dart';
import 'package:calley/otp_screen.dart';
import 'package:calley/session_data.dart';
import 'package:calley/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  clearController() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneNoController.clear();
  }

  

  List<String> countryList = ["+91", "+44", "	+61", "+1"];

  String selectedCountry = "+91";

  sinUpUser() async {
    if (_emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _nameController.text.trim().isNotEmpty &&
        _phoneNoController.text.trim().isNotEmpty &&
        selectedCountry != null) {
      SessionData.setSessionData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNo: _phoneNoController.text.trim(),
      );

      log("${SessionData.email}");
      Map<String, dynamic> userData = {
        "username": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      };

      Map<String, dynamic> otpData = {"email": _emailController.text.trim()};

      try {
        Uri url = Uri.parse("https://mock-api.calleyacd.com/api/auth/register");
        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(userData),
        );

        Uri otpUrl = Uri.parse(
          "https://mock-api.calleyacd.com/api/auth/send-otp",
        );
        http.Response otpResponse = await http.post(
          otpUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(otpData),
        );

        if (response.statusCode == 200 ||
            response.statusCode == 201 &&
                (otpResponse.statusCode == 200 ||
                    otpResponse.statusCode == 201)) {
          FocusScope.of(context).unfocus();
          clearController();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen()),
          );
          final result = jsonDecode(response.body);
          final otpResult = jsonDecode(otpResponse.body);

          log("$result");
          log("$otpResult");
        } else if (response.statusCode == 400) {
          CustomWidgets.customSnackbar(
            context: context,
            text: "User with this email already exists",
            color: Colors.red,
          );
        } else {
          log("${response.body}");
          log("${response.statusCode}");

          log("${otpResponse.body}");
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
       backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Image.asset("assets/png/Logo.png"),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(color: Color.fromRGBO(203, 213, 225, 1)),
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
                          CustomWidgets.customText(
                            text: "Welcome!",
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          CustomWidgets.customText(
                            text: "Please register to continue",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(102, 102, 102, 1),
                          ),
                          SizedBox(height: 20),
                          CustomWidgets.cunstomTextField(
                            text: "Name",
                            icon: Icon(Icons.person),
                            controller: _nameController,
                          ),
                          SizedBox(height: 20),
                          CustomWidgets.cunstomTextField(
                            text: "Email address",
                            icon: Icon(Icons.email_outlined),
                            controller: _emailController,
                          ),
                          SizedBox(height: 20),
                          CustomWidgets.cunstomTextField(
                            text: "Password",
                            icon: Icon(Icons.lock),
                            controller: _passwordController,
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(15, 23, 42, 0.04),
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: selectedCountry,
                                suffixIcon: Icon(FontAwesomeIcons.whatsapp),
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(203, 213, 225, 1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(203, 213, 225, 1),
                                  ),
                                ),
                              ),
                              items:
                                  countryList.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                selectedCountry = value.toString();
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomWidgets.cunstomTextField(
                            text: "Mobile number",
                            icon: Icon(Icons.phone_android_rounded),
                            controller: _phoneNoController,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: Color.fromRGBO(170, 170, 170, 1),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "I agree to the",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  " Terms and Conditions",
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(37, 99, 235, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          CustomWidgets.customRichText(
                            firstText: "Already have an account?",
                            secondText: "Sign In",
                            fun: () {
                              clearController();
                              FocusScope.of(context).unfocus();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          CustomWidgets.customElevatedButton(
                            text: "Sign Up",
                            fun: () {
                              FocusScope.of(context).unfocus();
                              sinUpUser();
                            },
                            width: double.infinity,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
