import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future _authenticate() async {
    bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;

    if (canAuthenticateWithBiometrics) {
      bool didAutehnticated = await _auth.authenticate(
        localizedReason: "Use biometric to unlock app",
        options: AuthenticationOptions(
          biometricOnly: false,
        ),
      );
      setState(() {
        isAuthenticated = didAutehnticated;
      });

      if (!isAuthenticated) {
        _showDialog("Authentication Failed. Try again.");
      }
    } else {
      _showDialog("Biometric authentication is not available.");
    }
  }

  void _showDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            actions: [
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _authenticate();
                    },
                    child: Text("Try Again")),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isAuthenticated)
            ? Center(
                child: Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ))
            : null);
  }
}
