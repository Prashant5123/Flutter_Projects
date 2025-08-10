import 'package:calley/language_screen.dart';
import 'package:calley/session_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer {
  static Widget _drawerItem({
    required String text,
    required IconData icon,
    required VoidCallback fun,
  }) {
    return ListTile(
      onTap: fun,
      leading: Container(
        width: 56,
        height: 40,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 4,
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  static Widget customDrawer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50 /*bottom: 60*/),
      child: Drawer(
        backgroundColor: Color.fromRGBO(238, 244, 254, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
        ),

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromRGBO(37, 99, 235, 1),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Image.asset("assets/png/profile .png"),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${SessionData.username}",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 5),

                          Text(
                            ".",
                            style: GoogleFonts.inter(
                              color: Color.fromRGBO(255, 199, 120, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 5),

                          Text(
                            "Personal",
                            style: GoogleFonts.inter(
                              color: Color.fromRGBO(255, 199, 120, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "${SessionData.userEmail}",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _drawerItem(
              text: "Getting Started",
              icon: Icons.rocket_launch,
              fun: () {},
            ),
            _drawerItem(text: "Sync Data", icon: Icons.sync, fun: () {}),
            _drawerItem(text: "Gamification", icon: Icons.widgets, fun: () {}),
            _drawerItem(text: "Send Logs", icon: Icons.call, fun: () {}),
            _drawerItem(text: "Settings", icon: Icons.settings, fun: () {}),
            _drawerItem(
              text: "Help?",
              icon: Icons.headphones_outlined,
              fun: () {},
            ),
            _drawerItem(
              text: "Cancel Subscription",
              icon: Icons.person_off_rounded,
              fun: () {},
            ),

            Divider(thickness: 1, color: Color.fromRGBO(203, 213, 225, 1)),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "App Info",
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(37, 99, 235, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            _drawerItem(
              text: "About Us",
              icon: Icons.account_box_outlined,
              fun: () {},
            ),
            _drawerItem(
              text: "Privacy Policy",
              icon: Icons.edit_document,
              fun: () {},
            ),

            _drawerItem(
              text: "Version 1.01.52",
              icon: Icons.door_back_door,
              fun: () {},
            ),
            _drawerItem(text: "Share App", icon: Icons.share, fun: () {}),

            _drawerItem(text: "Logout", icon: Icons.logout, fun: () async{
              await SessionData.setSignInDetails(username: "", userEmail: "", id: "", isLogin: false);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=> LanguageScreen()),(Route<dynamic> route)=>false);
            }),
          ],
        ),
      ),
    );
  }
}
