import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmanagement/state_management.dart';
import 'package:jobmanagement/user_bottom_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserDetails _userDetailsController = Get.put(UserDetails());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 91, 85, 243),
          title: Text(
            "Profile",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Icon(Icons.person, size: 100),
            ),

            SizedBox(
              height: 50,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ",

                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    " ${_userDetailsController.firstName }  ${_userDetailsController.lastName}",
                  
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),


                

              ],
            ),

            SizedBox(
              height: 20,
            ),

             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email: ",

                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    " ${_userDetailsController.email}",
                  
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      
      bottomNavigationBar: UserBottomNavigation().userBottomNavigation(
        context: context,
      ),
    );
  }
}
