import 'package:calley/custom_widgets.dart';
import 'package:calley/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> langName = [
    "English",
    "Hindi",
    "Bengali",
    "Kannada",
    "Punjabi",
    "Tamil",
    "Telugu",
    "French",
    "Spanish",
  ];
  List<String> langWord = [
    "Hi",
    "नमस्ते",
    "হাই",
    "ನಮಸ್ತೆ",
    "ਹੈਲੋ",
    "வணக்கம்",
    "హాయ్",
    "Bonjour",
    "Hola",
  ];
  String selectedLanguage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 250, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose Your Language",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color.fromRGBO(203, 213, 225, 1)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        color: Color.fromRGBO(15, 23, 42, 0.04),
                      ),
                    ],
                  ),

                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: langName.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        activeColor: Colors.black,
                        title: Text(
                          langName[index],
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        subtitle: Text(
                          langWord[index],
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(102, 102, 102, 1),
                          ),
                        ),
                        value: langName[index],
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          selectedLanguage = value.toString();
                          setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              CustomWidgets.customElevatedButton(
                text: "Select",
                 width: double.infinity,
                fun: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
