import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jobmanagement/applied_jobs.dart';
import 'package:jobmanagement/apply_job.dart';
import 'package:jobmanagement/signin_screen.dart';
import 'package:jobmanagement/state_management.dart';
import 'package:jobmanagement/user_bottom_navigation.dart';
import 'package:jobmanagement/user_search_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final UserDetails _userDetailsController = Get.put(UserDetails());

  String date = "";

  int selectedPage = 0;
  int previousPage = 0;
  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    date = DateFormat("EEEE, dd MMMM").format(dateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          leading: null,
          actions: [
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      // SessionData.setSessionData(isLogin: false, emailId: '');
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 91, 85, 243),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                date,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              ),
              Text(
                "Welcome ${_userDetailsController.firstName}",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Jobs",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _userDetailsController.allJobs.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _userDetailsController.jobIndex.value = index;
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ApplyJob()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 231, 230, 230),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_userDetailsController.allJobs[index]["title"]}",

                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${_userDetailsController.allJobs[index]["postedBy"]}",

                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Location: ${_userDetailsController.allJobs[index]["location"]}",

                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue[400],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: UserBottomNavigation().userBottomNavigation(
        context: context,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: const Color.fromARGB(255, 91, 85, 243),
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Colors.black,
      //   currentIndex: selectedPage,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (index) {
      //     previousPage = selectedPage;
      //     for (int i = 0; i < 3; i++) {
      //       if (i == index) {
      //         selectedPage = i;
      //       }
      //     }

      //     screenType(selectedPage);

      //     setState(() {});
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.save),
      //       label: "Applied Jobs",
      //     ),
      //   ],
      // ),
    );
  }

  // void screenType(int i) {
  //   if (i == 0 && previousPage != 0) {
  //     Navigator.of(
  //       context,
  //     ).push(MaterialPageRoute(builder: (context) => UserHomeScreen()));
  //   } else if (i == 1 && previousPage != 1) {
  //     Navigator.of(
  //       context,
  //     ).push(MaterialPageRoute(builder: (context) => UserSearchScreen()));
  //   } else if (i == 2 && previousPage != 2) {
  //     Navigator.of(
  //       context,
  //     ).push(MaterialPageRoute(builder: (context) => AppliedJobs()));
  //   }
  // }
}
