import 'package:coinboost/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Image.asset("assets/png/boost_logo.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "COINBOOST",
              style: GoogleFonts.robotoMono(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(247, 147, 26, 1),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset("assets/png/savings.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: 48,
                width: 307,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color:Color.fromRGBO(0, 0, 0, 0.25)
                    ),
                  ],
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Enter Your Mobile Number",
                      hintStyle: GoogleFonts.robotoMono(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(4, 3, 2, 0.26)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(222, 222, 222, 0.86))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(222, 222, 222, 0.86)))),
                ),
              ),
            ),

             SizedBox(
          height: 40,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            child: Container(
              height: 48,
              width: 307,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  Color.fromRGBO(247, 147, 26, 1),
                boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color:Color.fromRGBO(0, 0, 0, 0.25)
                        ),
                      ],
              ),child: Center(
                child: Text(
                    "Continue",
                    style: GoogleFonts.robotoMono(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),),
              ),
            ),
          ),
        )
          ],
                ),
              ),
        ));
  }
}
