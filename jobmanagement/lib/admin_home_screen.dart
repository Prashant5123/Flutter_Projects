import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jobmanagement/applied_users.dart';
import 'package:jobmanagement/custom_widgets.dart';
import 'package:jobmanagement/firebase_operations.dart';
import 'package:jobmanagement/signin_screen.dart';
import 'package:jobmanagement/state_management.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final UserDetails _userDetailsController = Get.put(UserDetails());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _postedByController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  String date = "";
  bool _isNew = true;
  int selectedPage = 0;
  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    date = DateFormat("EEEE, dd MMMM").format(dateTime);
    super.initState();
  }

  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
    _locationController.clear();
    _postedByController.clear();
  }

  Widget screenType(int index) {
    if (index == 2) {
      // return filter();
      return SizedBox();
    } else {
      //filterData = [];
      return AdminHomeScreen();
    }
  }

  void submitJob(bool isNew, int index) async {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty &&
        _postedByController.text.trim().isNotEmpty &&
        _salaryController.text.trim().isNotEmpty) {
      DateTime dateTime = DateTime.now();
      String formatedDate = DateFormat("M/d/y").format(dateTime);
      Map<String, dynamic> data = {
        "title": _titleController.text.trim(),
        "description": _descriptionController.text.trim(),
        "location": _locationController.text.trim(),
        "postedBy": _postedByController.text.trim(),
        "salary": _salaryController.text.trim(),
        "createdAt": formatedDate,
      };

      if (isNew) {
        await FirebaseFirestore.instance
            .collection("${_userDetailsController.panel}")
            .doc("${_userDetailsController.email}")
            .collection("Jobs")
            .add(data);
      } else {
        await FirebaseFirestore.instance
            .collection("${_userDetailsController.panel}")
            .doc("${_userDetailsController.email}")
            .collection("Jobs")
            .doc(_userDetailsController.allJobs[index]["id"])
            .update(data);
      }

      clearController();

      _userDetailsController.getAllJobs();

      setState(() {
        selectedPage = 0;
      });

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: (isNew)
              ? Text("Job added successfully.")
              : Text("Job edited successfully."),
        ),
      );
    } else {
      setState(() {
        // selectedPage = 0;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields.")));
    }
  }

  void openBottomSheet(bool isNew, int index) {
    if (isNew) {
      clearController();
    }
    if (!isNew) {
      _titleController.text = _userDetailsController.allJobs[index]["title"];
      _descriptionController.text =
          _userDetailsController.allJobs[index]["description"];
      _locationController.text =
          _userDetailsController.allJobs[index]["location"];
      _postedByController.text =
          _userDetailsController.allJobs[index]["postedBy"];
      _salaryController.text = _userDetailsController.allJobs[index]["salary"];
    }
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // title
                          Text(
                            "Job Title",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          CustomWidgets.customBottomSheetTextField(
                            controller: _titleController,
                            hintText: "Enter Job Title",
                          ),

                          SizedBox(height: 20),

                          // description
                          Text(
                            "Job Description",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          CustomWidgets.customBottomSheetTextField(
                            controller: _descriptionController,
                            hintText: "Enter Job Description",
                            maxLines: 5,
                          ),

                          SizedBox(height: 20),

                          // due date
                          Text(
                            "Location",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          CustomWidgets.customBottomSheetTextField(
                            controller: _locationController,
                            hintText: "Enter Job Location",
                          ),

                          SizedBox(height: 20),

                          // Priority
                          Text(
                            "Salary",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          CustomWidgets.customBottomSheetTextField(
                            controller: _salaryController,
                            hintText: "Enter Salary",
                          ),

                          SizedBox(height: 20),

                          // Priority
                          Text(
                            "Posted By",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          CustomWidgets.customBottomSheetTextField(
                            controller: _postedByController,
                            hintText: "Enter Job Offering Company Name",
                          ),

                          SizedBox(height: 20),

                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: WidgetStatePropertyAll(
                                  Size(MediaQuery.of(context).size.width, 40),
                                ),
                                backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 91, 85, 243),
                                ),
                              ),
                              onPressed: () {
                                submitJob(isNew, index);
                              },
                              child: (isNew)
                                  ? Text(
                                      "Add Job",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Edit Job",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        // selectedPage = 0; // Ensure Home is selected
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
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
                "All Jobs",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: SlidableAutoCloseBehavior(
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
                        child: Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.18,
                            motion: ScrollMotion(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _isNew = false;
                                        openBottomSheet(_isNew, index);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: const Color.fromARGB(
                                          255,
                                          91,
                                          85,
                                          243,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection(
                                              "${_userDetailsController.panel}",
                                            )
                                            .doc(
                                              "${_userDetailsController.email}",
                                            )
                                            .collection("Jobs")
                                            .doc(
                                              _userDetailsController
                                                  .allJobs[index]["id"],
                                            )
                                            .delete();

                                        _userDetailsController.getAllJobs();

                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: const Color.fromARGB(
                                          255,
                                          91,
                                          85,
                                          243,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _userDetailsController.adminJobIndex.value =
                                  index;
                              _userDetailsController.getappliedUsersJobs(
                                id: _userDetailsController.allJobs[index]["id"],
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AppliedUsers(),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    231,
                                    230,
                                    230,
                                  ),
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
                                      "${_userDetailsController.allJobs[index]["description"]}",

                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Location: ${_userDetailsController.allJobs[index]["location"]}",

                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red[400],
                                          ),
                                        ),
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
                                          "PostedBy: ${_userDetailsController.allJobs[index]["postedBy"]}",

                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.pink[50],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Salary: ${_userDetailsController.allJobs[index]["salary"]}",

                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.pink[400],
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Posted At: ${_userDetailsController.allJobs[index]["createdAt"]}",

                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green[400],
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
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 91, 85, 243),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: selectedPage,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedPage = index;
            if (index == 1) {
              _isNew = true;
              openBottomSheet(_isNew, -1);
            } else {
              screenType(index);
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Job"),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt_outlined),
            label: "Filters",
          ),
        ],
      ),
    );
  }
}
