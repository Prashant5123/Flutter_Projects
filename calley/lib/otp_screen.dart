import 'dart:convert';
import 'dart:developer';

import 'package:calley/custom_widgets.dart';
import 'package:calley/home_screen.dart';
import 'package:calley/session_data.dart';
import 'package:calley/signin_screen.dart';
import 'package:calley/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  void initState() {
    // TODO: implement initState
    log("-------------------");
    
    log("${SessionData.email}");
  }
  String? otp;
  verifyOtp() async {
    if (otp != null) {
      log("${SessionData.email}");
      Map<String, dynamic> otpData = {
        "email": SessionData.email,
        "otp": otp,
      };
      try {
        Uri url = Uri.parse(
          "https://mock-api.calleyacd.com/api/auth/verify-otp",
        );
        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(otpData)
        );

        final result = jsonDecode(response.body);



        if(response.statusCode==200 || response.statusCode==201){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
          log("In if");

          log("${result}");
          log("${response.statusCode}");
        }else{
          CustomWidgets.customSnackbar(context: context, text: "Wrong otp", color: Colors.red);
          log("in else");
          log("${response.body}");
          log("${response.statusCode}");
        }
      } catch (e) {

        log("$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top),
              SizedBox(height: 30),
              Image.asset("assets/png/Logo.png"),

              Spacer(),

              Container(
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
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),

                      Text(
                        "Whatsapp OTP Verification",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),

                      Text(
                        "Please ensure that the email id mentioned is valid as we have sent an OTP to your email.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                      SizedBox(height: 20),

                      OtpTextField(
                        fieldWidth: 48,
                        fieldHeight: 50,
                        numberOfFields: 6,
                        showFieldAsBox: true,
                        onSubmit: (value) {
                          otp = value;
                        },
                        enabledBorderColor: Color.fromRGBO(203, 213, 225, 1),
                        focusedBorderColor: Color.fromRGBO(203, 213, 225, 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "+91 7676286822?",

                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 150),

                      CustomWidgets.customRichText(
                        firstText: "Didn't receive OTP code?",
                        secondText: "Resend OTP",
                        fun: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 10),

                      CustomWidgets.customElevatedButton(
                        text: "Verify",
                        fun: () {
                          verifyOtp();
                        },
                         width: double.infinity
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
