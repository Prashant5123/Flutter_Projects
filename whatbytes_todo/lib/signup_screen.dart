import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatbytes_todo/loader.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailSiginController = TextEditingController();
  final TextEditingController _passwordSiginController =
      TextEditingController();
  final TextEditingController _comPasswordSiginController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isObscure = true;
  bool _isComObscure = true;
  bool _isLoading = false;

  // FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: GoogleFonts.quicksand(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailSiginController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: (_isObscure) ? true : false,
                          controller: _passwordSiginController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  if (_isObscure) {
                                    _isObscure = false;
                                    setState(() {});
                                  } else {
                                    _isObscure = true;
                                    setState(() {});
                                  }
                                },
                                child: (_isObscure)
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: (_isComObscure) ? true : false,
                          controller: _comPasswordSiginController,
                          onFieldSubmitted: (value) {
                            if (value != _passwordSiginController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Password did not match")));
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  if (_isComObscure) {
                                    _isComObscure = false;
                                    setState(() {});
                                  } else {
                                    _isComObscure = true;
                                    setState(() {});
                                  }
                                },
                                child: (_isComObscure)
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            labelText: "Comform Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(340, 30),
                              backgroundColor:
                                  const Color.fromARGB(255, 91, 85, 243),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _isLoading
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
                                            .isNotEmpty &&
                                        _comPasswordSiginController.text
                                            .trim()
                                            .isNotEmpty &&
                                        _passwordSiginController.text.trim() ==
                                            _comPasswordSiginController.text
                                                .trim()) {
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email:
                                              _emailSiginController.text.trim(),
                                          password: _passwordSiginController
                                              .text
                                              .trim(),
                                        );
        
                                        Map<String, dynamic> data = {
                                          "firstName":
                                              _firstNameController.text.trim(),
                                          "lastName":
                                              _lastNameController.text.trim(),
                                          "email":
                                              _emailSiginController.text.trim(),
                                        };
        
                                        await FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(_emailSiginController.text
                                                .trim())
                                            .set(data);
        
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Account Created Successfully"),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
        
                                        Navigator.pop(context);
                                      } on FirebaseAuthException catch (error) {
                                        String formattedError = error.code
                                            .toString()
                                            .split("-")
                                            .map((word) => word.isNotEmpty
                                                ? word[0].toUpperCase() +
                                                    word.substring(1)
                                                : "")
                                            .join(" ");
        
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(formattedError),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Enter valid data"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
        
                                      // Optional: Wait a bit to prevent instant re-tapping
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                    }
        
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
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
                                    "Sign Up",
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            height: 1,
                            width: 300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Already have an account",
                                style: GoogleFonts.quicksand(
                                    fontSize: 23, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 30,
                                  width: 60,
                                  child: Text("Login",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 91, 85, 243),
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
