import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget customTextField({
    required TextEditingController? controller,
    required Widget label,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        label: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
          ),
          //borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
          //borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
          //borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
