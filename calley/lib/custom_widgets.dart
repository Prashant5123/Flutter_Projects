import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  static Widget customText({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static Widget cunstomTextField({
    required String text,
    required Icon icon,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.04),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: icon,
          hintText: text,
          hintStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromRGBO(203, 213, 225, 1)),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromRGBO(203, 213, 225, 1)),
          ),
        ),
      ),
    );
  }

  static Widget customElevatedButton({
    required String text,
     double? width,
    required VoidCallback fun,
  }) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
          backgroundColor: WidgetStatePropertyAll(
            Color.fromRGBO(37, 99, 235, 1),
          ),
        ),
        onPressed: fun,
        child: CustomWidgets.customText(
          text: text,
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget customRichText({
    required String firstText,
    required String secondText,
    required VoidCallback fun,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 5),

        GestureDetector(
          onTap: fun,
          child: Text(
            secondText,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(37, 99, 235, 1),
            ),
          ),
        ),
      ],
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  customSnackbar({
    required BuildContext context,
    required String text,
    required Color color,
  }) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }
}
