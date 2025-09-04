import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:jobmanagement/state_management.dart';

class ApplyJob extends StatefulWidget {
  const ApplyJob({super.key});

  @override
  State<ApplyJob> createState() => _ApplyJobState();
}

class _ApplyJobState extends State<ApplyJob> {
  final UserDetails _userDetailsController = Get.put(UserDetails());
  final TextEditingController _textEditingController = TextEditingController();
  String? _selectedValue;
  String? selectedFilePath;
  File? selectedFile;
  bool isloading = false;
  String? formatedPath;
  String? downloadUrl;

  Future selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );

    if (result != null) {
      selectedFilePath = result.files.single.path;
      selectedFile = File(selectedFilePath!);
      formatedPath = result.files.single.name;
    }

    log("${selectedFilePath}");
    setState(() {});
  }

  Future uploadPdf() async {
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("${formatedPath!.split(".").first}_$filename.pdf")
          .putFile(selectedFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = _userDetailsController.jobIndex.value;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },

              color: Colors.white,
            ),
            backgroundColor: const Color.fromARGB(255, 91, 85, 243),
            title: Text(
              "Applying to ${_userDetailsController.allJobs[index]["title"]} Job ",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${_userDetailsController.allJobs[index]["title"]}",

                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${_userDetailsController.allJobs[index]["postedBy"]}",

                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.money),
                    SizedBox(width: 10),
                    Text(
                      "₹ ${_userDetailsController.allJobs[index]["salary"]}/year",

                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 10),
                    Text(
                      "${_userDetailsController.allJobs[index]["location"]}",

                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.access_time_rounded),
                    SizedBox(width: 10),
                    Text(
                      "${_userDetailsController.allJobs[index]["createdAt"]}",

                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Divider(),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "About the job",

                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${_userDetailsController.allJobs[index]["description"]}",

                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              Divider(),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Apply Now",

                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Confirm your availability",

                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),

                    Text(
                      "*",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              RadioGroup(
                groupValue: _selectedValue,
                onChanged: (value) {
                  _selectedValue = value;
                  setState(() {});
                },
                child: Column(
                  children: [
                    RadioListTile(
                      value: "Yes, I am available to join immediately",
                      title: Text(
                        "Yes, I am available to join immediately",

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    RadioListTile(
                      value: "No, I am currently on notice period",
                      title: Text(
                        "No, I am currently on notice period",

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    RadioListTile(
                      value: "No, I will have to serve notice period",
                      title: Text(
                        "No, I will have to serve notice period",

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Why we hire you",

                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 5),

                    Text(
                      "*",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _textEditingController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Divider(),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Custom Resume",

                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(width: 5),

                    Text(
                      "*",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: (selectedFilePath == null)
                      ? GestureDetector(
                          onTap: () async {
                            await selectPdf();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: Color.fromARGB(255, 91, 85, 243),
                              ),
                              Text(
                                "Upload Resume",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 91, 85, 243),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  OpenFile.open(selectedFilePath);
                                },
                                child: Text(
                                  "$formatedPath",

                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                selectedFilePath = null;
                                selectedFile = null;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.close,
                                size: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Max file size: 10Mb. File type - PDF",

                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 91, 85, 243),
                      ),
                    ),
                    onPressed: (isloading)
                        ? null
                        : () async {
                            if (_selectedValue != null &&
                                _textEditingController.text.trim().isNotEmpty &&
                                selectedFile != null &&
                                selectedFilePath != null) {
                              setState(() {
                                isloading = true;
                              });
                              await uploadPdf();
                              DateTime dateTime = DateTime.now();
                              String formatedDate = DateFormat(
                                'd/M/y',
                              ).format(dateTime);
                              try {
                                FirebaseFirestore firebaseFirestore =
                                    FirebaseFirestore.instance;
                                Map<String, dynamic> data = {
                                  "userName":
                                      "${_userDetailsController.firstName} ${_userDetailsController.lastName}",
                                  "userEmail":
                                      "${_userDetailsController.email}",
                                  "whyHire": _textEditingController.text.trim(),
                                  "availability": _selectedValue,
                                  "appliedAt": formatedDate,
                                  "resumeUrl": downloadUrl,
                                  "resumeFileName": formatedPath,
                                };
                                await firebaseFirestore
                                    .collection("Admin")
                                    .doc("prashant@gmail.com")
                                    .collection("Jobs")
                                    .doc(
                                      _userDetailsController
                                          .allJobs[index]["id"],
                                    )
                                    .collection("applied_users")
                                    .add(data);

                                Map<String, dynamic> appliedId =
                                    _userDetailsController.allJobs[index];
                                appliedId["appliedAt"] = formatedDate;
                                appliedId["resumeLink"] = downloadUrl;
                                appliedId["id"] =
                                    _userDetailsController.allJobs[index]["id"];
                                await firebaseFirestore
                                    .collection("User")
                                    .doc(_userDetailsController.email.value)
                                    .collection("applied_jobs")
                                    .add(appliedId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Successfully applied for job",
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                  setState(() {
                                isloading = false;
                              });

                              _userDetailsController.getUserAllJobs();
                                Navigator.of(context).pop();
                              } catch (e) {}
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please fill required fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    child: (isloading)
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
