import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:job_management/custom_widgets.dart';
import 'package:job_management/home_screen.dart';
import 'package:job_management/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State createState() => _SigninScreen();
}

class _SigninScreen extends State {
   final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();
  bool isObscure = true;
  bool _isLoading = false;
  List<bool> selectedPanelList = [false, true];
  List<String> panelList = ["Admin", "User"];
  String selectedPanel = "User";

  void _clearController(){
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          selectedBorderColor: Color.fromARGB(255, 91, 85, 243),
                          isSelected: selectedPanelList,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          selectedColor: Colors.white,
                          color: Colors.black,
                          fillColor: Color.fromARGB(255, 91, 85, 243),
                          onPressed: (index) {
                            for (int i = 0; i < selectedPanelList.length; i++) {
                              selectedPanelList[i] = i == index;
                            }
                            selectedPanel = panelList[index];
                            setState(() {});
                          },
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              child: Center(child: Text(panelList[0])),
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              child: Center(child: Text(panelList[1])),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      CustomWidgets.customTextFormField(
                        obscureText: false,
                        controller: _emailLoginController,
                        prefixIcon: Icon(AntDesign.mail_outline),
                        labelText: "Email",
                      ),

                      const SizedBox(height: 20),

                      CustomWidgets.customTextFormField(
                        obscureText: isObscure,
                        controller: _passwordLoginController,
                        prefixIcon: Icon(AntDesign.lock_fill),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (isObscure) {
                              isObscure = false;
                              setState(() {});
                            } else {
                              isObscure = true;
                              setState(() {});
                            }
                          },
                          icon:
                              (isObscure)
                                  ? Icon(AntDesign.eye_invisible_fill)
                                  : Icon(AntDesign.eye_fill),
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
                          onPressed:
                              _isLoading
                                  ? null
                                  : () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_emailLoginController.text
                                            .trim()
                                            .isNotEmpty &&
                                        _passwordLoginController.text
                                            .trim()
                                            .isNotEmpty) {
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                              email: _emailLoginController.text,
                                              password:
                                                  _passwordLoginController.text,
                                            );
                                        // SessionData.setSessionData(
                                        //     isLogin: true,
                                        //     emailId: _emailLoginController.text
                                        //         .trim());

                                        DocumentSnapshot response =
                                            await FirebaseFirestore.instance
                                                .collection("user")
                                                .doc(_emailLoginController.text)
                                                .get();

                                        Map data = response.data() as Map;

                                        // ref.read(riverPodHard).name =
                                        //     data["firstName"];

                                        //log("$data");
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Logn in successfully",
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                        );

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      } on FirebaseAuthException catch (error) {
                                        String formatedError = error.code
                                            .toString()
                                            .split("-")
                                            .map(
                                              (word) =>
                                                  word[0].toUpperCase() +
                                                  word.substring(1),
                                            )
                                            .join(" ");

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(formatedError),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Enter valid data"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }

                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                          child:
                              _isLoading
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
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                                _clearController();
                              },
                              child: SizedBox(
                                height: 30,

                                child: Text(
                                  "Create new account",
                                  style:GoogleFonts.quicksand(
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
    );
  }
}
