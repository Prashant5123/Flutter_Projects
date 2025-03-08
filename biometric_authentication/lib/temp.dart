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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Account Balance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (isAuthenticated)
              Text(
                "25000",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            if (!isAuthenticated)
              Text(
                "*********",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!isAuthenticated) {
            final bool canAuthenticateWithBiometrics =
                await _auth.canCheckBiometrics;

            try {
              if (canAuthenticateWithBiometrics) {
                bool didAutehnticated = await _auth.authenticate(
                    localizedReason: "Authenticate to see your account balance",
                    options: AuthenticationOptions(biometricOnly: false));
                setState(() {
                  isAuthenticated = didAutehnticated;
                });
              }else{}
            } catch (e) {
              log("$e");
            }
          } else {
            setState(() {
              isAuthenticated = false;
            });
          }
        },
        child: (isAuthenticated)
            ? Icon(Icons.lock_open_rounded)
            : Icon(Icons.lock_outline_rounded),
      ),
    );
  }
}
