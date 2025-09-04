import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmanagement/custom_pdf_viewer.dart';
import 'package:jobmanagement/state_management.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AppliedUsers extends StatefulWidget {
  const AppliedUsers({super.key});

  @override
  State<AppliedUsers> createState() => _AppliedUsersState();
}

class _AppliedUsersState extends State<AppliedUsers> {
  final UserDetails _userDetailsController = Get.put(UserDetails());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 30,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },

            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 91, 85, 243),
          title: Text(
            "Applied users for ${_userDetailsController.allJobs[  _userDetailsController.adminJobIndex.value]["title"]} Job ",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: _userDetailsController.appliedUsers.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Name: ${_userDetailsController.appliedUsers[index]["userName"]}",

                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Email: ${_userDetailsController.appliedUsers[index]["userEmail"]}",

                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Why hire them: ${_userDetailsController.appliedUsers[index]["whyHire"]}",

                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Availability: ${_userDetailsController.appliedUsers[index]["availability"]}",

                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Resume: ",

                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CustomPdfViewer(
                                        path: _userDetailsController
                                            .appliedUsers[index]["resumeUrl"],
                                            fileName: _userDetailsController
                                            .appliedUsers[index]["resumeFileName"], 
                                      ),
                                    ),
                                  );
                                  // SfPdfViewer.network(
                                  //   _userDetailsController
                                  //       .appliedUsers[index]["resumeUrl"],
                                  // );
                                },
                                child: Text(
                                  "${_userDetailsController.appliedUsers[index]["resumeFileName"]}",

                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Divider(),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
