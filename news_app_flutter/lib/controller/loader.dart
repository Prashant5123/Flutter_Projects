import 'dart:ui';

import 'package:flutter/material.dart';

class Loader {
  static Widget circularLoading(){
    return Stack(
            children: [
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              // Loading spinner
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
  }
}