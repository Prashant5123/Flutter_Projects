import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobmanagement/custom_widgets.dart';

import 'package:jobmanagement/admin_home_screen.dart';
import 'package:jobmanagement/session_data.dart';
import 'package:jobmanagement/signup_screen.dart';
import 'package:jobmanagement/state_management.dart';
import 'package:jobmanagement/user_home_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State createState() => _SigninScreen();
}

class _SigninScreen extends State<SigninScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();

  final UserDetails _userDetailsController = Get.put(UserDetails());
  bool isObscure = true;
  bool _isLoading = false;
  List<bool> selectedPanelList = [false, true];
  List<String> panelList = ["Admin", "User"];
  String selectedPanel = "User";

  void _clearController() {
    _emailLoginController.clear();
    _passwordLoginController.clear();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _passwordLoginController.dispose();
    _emailLoginController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    if (_emailLoginController.text.trim().isEmpty ||
        _passwordLoginController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter valid data"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      DocumentSnapshot data = await firebaseFirestore
          .collection(selectedPanel)
          .doc(_emailLoginController.text.trim())
          .get();

      if (!data.exists || data.data() == null) {
        throw FirebaseAuthException(
          code: "user-not-found",
          message: "user-not-found",
        );
      }

      Map<String, dynamic> userData = data.data()! as Map<String, dynamic>;

      if ((userData["panel"] ?? "") != selectedPanel) {
        throw FirebaseAuthException(
          code: "user-not-found",
          message: "user-not-found",
        );
      }

      _userDetailsController.fillUserDetail(
        firstName: userData["firstName"] ?? "",
        lastName: userData["lastName"] ?? "",
        email: userData["email"] ?? "",
        panel: userData["panel"] ?? "",
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailLoginController.text.trim(),
        password: _passwordLoginController.text.trim(),
      );

      _userDetailsController.allJobs.clear();
      if (selectedPanel == "Admin") {
        _userDetailsController.getAllJobs();
      } else {
        _userDetailsController.getUserAllJobs();
        
      }

      await SessionData.setSessionData(
        email: _emailLoginController.text.trim(),
        isLogin: true,
        panel: selectedPanel,
        name: userData["firstName"],
        lastName: userData["lastName"]
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              (selectedPanel == "Admin") ? AdminHomeScreen() : UserHomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (error) {
      log("${error.code}");
      log("${error.message}");
     
      String formattedError = error.code
          .split("-")
          .map((word) => "${word[0].toUpperCase()}${word.substring(1)}")
          .join(" ");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(formattedError), backgroundColor: Colors.red),
      );
    } catch (e) {
       log("${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An unexpected error occurred: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.quicksand(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ToggleButtons(
                            borderWidth: 2,
                            selectedBorderColor: const Color.fromARGB(
                              255,
                              91,
                              85,
                              243,
                            ),
                            isSelected: selectedPanelList,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            selectedColor: Colors.white,
                            color: Colors.black,
                            fillColor: const Color.fromARGB(255, 91, 85, 243),
                            onPressed: (index) {
                              for (
                                int i = 0;
                                i < selectedPanelList.length;
                                i++
                              ) {
                                selectedPanelList[i] = i == index;
                              }
                              selectedPanel = panelList[index];
                              setState(() {});
                            },
                            children: [
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                    2,
                                child: Center(child: Text(panelList[0])),
                              ),
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                    2,
                                child: Center(child: Text(panelList[1])),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomWidgets.customTextFormField(
                          obscureText: false,
                          controller: _emailLoginController,
                          prefixIcon: const Icon(AntDesign.mail_outline),
                          labelText: "Email",
                        ),
                        const SizedBox(height: 20),
                        CustomWidgets.customTextFormField(
                          obscureText: isObscure,
                          controller: _passwordLoginController,
                          prefixIcon: const Icon(AntDesign.lock_fill),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            icon: isObscure
                                ? const Icon(AntDesign.eye_invisible_fill)
                                : const Icon(AntDesign.eye_fill),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                91,
                                85,
                                243,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _isLoading ? null : _login,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Login",
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Container(
                            height: 1,
                            width: 300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Don't have an Account",
                                style: GoogleFonts.quicksand(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const SignupScreen(),
                                    ),
                                  );
                                  _clearController();
                                },
                                child: SizedBox(
                                  height: 30,
                                  child: Text(
                                    "Create new account",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                        255,
                                        91,
                                        85,
                                        243,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
