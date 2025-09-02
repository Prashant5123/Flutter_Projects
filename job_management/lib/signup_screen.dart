import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:job_management/custom_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailSiginController = TextEditingController();
  final TextEditingController _passwordSiginController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isObscure = true;

  bool _isLoading = false;
  List<bool> _selectedPanelList = [false, true];
  List<String> _panelList = ["Admin", "User"];
  String _selectedPanel = "User";

  void _clearController() {
    _emailSiginController.clear();
    _passwordSiginController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create New Account",
                            style: GoogleFonts.quicksand(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Center(
                            child: ToggleButtons(
                              borderWidth: 2,
                              selectedBorderColor: Color.fromARGB(
                                255,
                                91,
                                85,
                                243,
                              ),
                              isSelected: _selectedPanelList,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              selectedColor: Colors.white,
                              color: Colors.black,
                              fillColor: Color.fromARGB(255, 91, 85, 243),
                              onPressed: (index) {
                                for (
                                  int i = 0;
                                  i < _selectedPanelList.length;
                                  i++
                                ) {
                                  _selectedPanelList[i] = i == index;
                                }
                                _selectedPanel = _panelList[index];
                                setState(() {});
                              },
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 60) /
                                      2,
                                  child: Center(child: Text(_panelList[0])),
                                ),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 60) /
                                      2,
                                  child: Center(child: Text(_panelList[1])),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          CustomWidgets.customTextFormField(
                            controller: _firstNameController,
                            prefixIcon: Icon(EvaIcons.person),
                            labelText: "First Name",
                            obscureText: false,
                          ),
                          SizedBox(height: 20),
                          CustomWidgets.customTextFormField(
                            controller: _lastNameController,
                            prefixIcon: Icon(EvaIcons.person),
                            labelText: "Last Name",
                            obscureText: false,
                          ),
                          SizedBox(height: 20),

                          CustomWidgets.customTextFormField(
                            controller: _emailSiginController,
                            prefixIcon: Icon(AntDesign.mail_outline),
                            labelText: "Email",
                            obscureText: false,
                          ),

                          const SizedBox(height: 20),

                          CustomWidgets.customTextFormField(
                            obscureText: _isObscure,
                            controller: _passwordSiginController,
                            prefixIcon: Icon(AntDesign.lock_fill),
                            labelText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (_isObscure) {
                                  _isObscure = false;
                                  setState(() {});
                                } else {
                                  _isObscure = true;
                                  setState(() {});
                                }
                              },
                              icon:
                                  (_isObscure)
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

                                        if (_firstNameController.text
                                                .trim()
                                                .isNotEmpty &&
                                            _lastNameController.text
                                                .trim()
                                                .isNotEmpty &&
                                            _emailSiginController.text
                                                .trim()
                                                .isNotEmpty &&
                                            _passwordSiginController.text
                                                .trim()
                                                .isNotEmpty) {
                                          try {
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                  email:
                                                      _emailSiginController.text
                                                          .trim(),
                                                  password:
                                                      _passwordSiginController
                                                          .text
                                                          .trim(),
                                                );

                                            Map<String, dynamic> data = {
                                              "firstName":
                                                  _firstNameController.text
                                                      .trim(),
                                              "lastName":
                                                  _lastNameController.text
                                                      .trim(),
                                              "email":
                                                  _emailSiginController.text
                                                      .trim(),
                                            };

                                            await FirebaseFirestore.instance
                                                .collection("user")
                                                .doc(
                                                  _emailSiginController.text
                                                      .trim(),
                                                )
                                                .set(data);

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Account Created Successfully",
                                                ),
                                                backgroundColor: Colors.green,
                                              ),
                                            );

                                            Navigator.pop(context);
                                          } on FirebaseAuthException catch (
                                            error
                                          ) {
                                            String formattedError = error.code
                                                .toString()
                                                .split("-")
                                                .map(
                                                  (word) =>
                                                      word.isNotEmpty
                                                          ? word[0]
                                                                  .toUpperCase() +
                                                              word.substring(1)
                                                          : "",
                                                )
                                                .join(" ");

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(formattedError),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("Enter valid data"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );

                                          // Optional: Wait a bit to prevent instant re-tapping
                                          await Future.delayed(
                                            const Duration(seconds: 1),
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
                                        "Sign Up",
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
                                  "Already have an account",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _clearController();
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    height: 30,
                                    width: 60,
                                    child: Text(
                                      "Login",
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
      ),
    );
  }
}
