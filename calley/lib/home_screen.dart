import 'package:calley/custom_drawer.dart';
import 'package:calley/custom_widgets.dart';
import 'package:calley/session_data.dart';
import 'package:calley/state_management.dart';
import 'package:calley/test_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<StateManagement>(context, listen: false).getUserData();
  }


 
  int selectedIndex = 2;
  openBottomAheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 261,
              child: Stack(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Color.fromRGBO(30, 51, 101, 1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "CALLING LISTS",
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(239, 246, 255, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Select Calling List",
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),

                                    Container(
                                      height: 32,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color.fromRGBO(37, 99, 235, 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.refresh,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Refresh",
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TestList(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(239, 246, 255, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Test List",
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Spacer(),

                                      Center(
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 250, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: Icon(Icons.dehaze_outlined),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                  ),

                  SizedBox(width: 10),

                  CustomWidgets.customText(
                    text: "Dashboard",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  Spacer(),
                  Icon(Icons.headset_mic_outlined),

                  SizedBox(width: 20),

                  Icon(Icons.notifications),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                            
                  Container(
                    height: 94,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 99, 235, 1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color.fromRGBO(203, 213, 225, 1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0, 1),
                          color: Color.fromRGBO(15, 23, 42, 0.04),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Image.asset("assets/png/profile .png"),
                            
                        SizedBox(width: 20),
                            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomWidgets.customText(
                              text: "Hello ${SessionData.username}",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            CustomWidgets.customText(
                              text: "Welcome to Calley!",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                            
                  SizedBox(height: 20),
                            
                  SizedBox(
                    height: 411,
                    child: Stack(
                      children: [
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Color.fromRGBO(30, 51, 101, 1),
                          ),
                        ),
                            
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 361,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromRGBO(203, 213, 225, 1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Color.fromRGBO(15, 23, 42, 0.04),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "Visit https://app.getcalley.com to upload numbers that you wish to call using Calley Mobile App.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                            
                                SizedBox(height: 10),
                                Spacer(),
                            
                                Image.asset('assets/png/image 108.png'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                            
                  SizedBox(height: 20),
                            
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromRGBO(14, 176, 29, 1),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.squareWhatsapp,
                          color: Color.fromRGBO(14, 176, 29, 1),
                          size: 30,
                        ),
                      ),
                            
                      SizedBox(width: 20),
                            
                      // ElevatedButton(onPressed: (){}, child:Text("Gvcxxv")),
                      Expanded(
                        child: CustomWidgets.customElevatedButton(
                          text: "Start Calling Now",
                          fun: () {
                            openBottomAheet();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color.fromRGBO(37, 99, 235, 1),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,

          backgroundColor: Color.fromRGBO(219, 238, 255, 1),

          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.idCard),
              label: '',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.play),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_callback, size: 25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendar),
              label: '',
            ),
          ],
        ),
      ),

      drawer: CustomDrawer.customDrawer(context),
    );
  }
}
