import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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


  static Widget customBottomSheetTextField({required TextEditingController controller,required String hintText,int? maxLines}){
    return   TextField(
                            controller: controller,
                            maxLines: maxLines,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              hintText:  hintText,
                              hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
  }
}
