import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomWidgets {
static  Widget customTextFormField({
    required TextEditingController controller,
    required Icon  prefixIcon,
    required String labelText,
    IconButton? suffixIcon,
    required bool obscureText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText:  obscureText!,
      decoration: InputDecoration(
        prefixIcon:  prefixIcon,
        
        suffixIcon:suffixIcon ,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
