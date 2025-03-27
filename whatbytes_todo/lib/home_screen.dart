import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whatbytes_todo/riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> priorityList = ["Low", "Medium", "High"];
  String? priority;
  String? taskPriority;
  String? taskStatus;
  List filterData = [];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  void submitTask(bool isNew, int index) async {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty &&
        priority != null) {
      Map<String, dynamic> data = {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "date": _dateController.text,
        "priority": priority,
        "status": "Incompleted"
      };

      if (isNew) {
         
        await FirebaseFirestore.instance.collection("Tasks").add(data);
      } else {
        Map<String, dynamic> _data = {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "date": _dateController.text,
        "priority": priority,
        "status": ref.read(riverPodHard).firebasData[index]["status"]
      };
        await FirebaseFirestore.instance
            .collection("Tasks")
            .doc(ref.watch(riverPodHard).firebasData[index]["id"])
            .update(_data);
      }

      clearController();

      log("Task added");

      setState(() {
        selectedPage = 0;
        ref.read(riverPodHard).getFirebaseData();
      });

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: (isNew)
              ? Text("Task added successfully.")
              : Text("Task edited successfully.")));
    } else {
      setState(() {
        selectedPage = 0;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all fields.")));
    }
  }

  int selectedPage = 0;
  bool isNew = true;

  void openBottomSheet(bool isNew, int index) {
    if (!isNew) {
      _dateController.text = ref.watch(riverPodHard).firebasData[index]["date"];
      _descriptionController.text =
          ref.watch(riverPodHard).firebasData[index]["description"];
      _titleController.text =
          ref.watch(riverPodHard).firebasData[index]["title"];
      priority = ref.watch(riverPodHard).firebasData[index]["priority"];
    }
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        Text(
                          "Title",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        TextField(
                          controller: _titleController,
                          maxLines: null,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Enter Title",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                             
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // description
                        Text(
                          "Description",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        TextField(
                          maxLines: 5,
                          controller: _descriptionController,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              hintText: "Enter Description",
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // due date
                        Text(
                          "Due Date",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        TextField(
                          maxLines: null,
                          controller: _dateController,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030));
                            String formatDate =
                                DateFormat("dd MMMM yyyy").format(date!);
                            _dateController.text = formatDate;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Enter Due Date",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Priority
                        Text(
                          "Priority",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        DropdownButtonFormField(
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Select Priority",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          items: priorityList.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            priority = value;
                            log(priority!);
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: WidgetStatePropertyAll(Size(
                                      MediaQuery.of(context).size.width, 40)),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color.fromARGB(255, 91, 85, 243),
                                  )),
                              onPressed: () {
                                submitTask(isNew, index);
                              },
                              child: (isNew)
                                  ? Text(
                                      "Add Task",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )
                                  : Text(
                                      "Edit Task",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        selectedPage = 0; // Ensure Home is selected
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 91, 85, 243),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                ref.watch(riverPodHard).date,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                "Welcome ${ref.read(riverPodHard).name}",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      body: screenType(selectedPage),
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
              isNew = true;
              openBottomSheet(isNew, -1);
            } else {
              screenType(index);
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt_outlined), label: "Filters"),
        ],
      ),
    );
  }

  Widget home() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "All Tasks",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SlidableAutoCloseBehavior(
            child: ListView.builder(
                itemCount: ref.watch(riverPodHard).firebasData.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.18,
                        motion: ScrollMotion(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isNew = false;
                                    openBottomSheet(isNew, index);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color:
                                        const Color.fromARGB(255, 91, 85, 243),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection("Tasks")
                                        .doc(ref
                                            .read(riverPodHard)
                                            .firebasData[index]["id"])
                                        .delete();
                                    ref.read(riverPodHard).getFirebaseData();
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color:
                                        const Color.fromARGB(255, 91, 85, 243),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      child: Container(
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
                                ref.watch(riverPodHard).firebasData[index]
                                    ["title"],
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                ref.watch(riverPodHard).firebasData[index]
                                    ["description"],
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Priority:${ref.watch(riverPodHard).firebasData[index]["priority"]}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red[400]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Due Date:${ref.watch(riverPodHard).firebasData[index]["date"]}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue[400]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Mark as completed",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["status"] ==
                                          "Incompleted") {
                                        Map<String, dynamic> data = {
                                          "title": ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["title"],
                                          "description": ref
                                                  .watch(riverPodHard)
                                                  .firebasData[index]
                                              ["description"],
                                          "date": ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["date"],
                                          "priority": ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["priority"],
                                          "status": "Completed"
                                        };
                                        await FirebaseFirestore.instance
                                            .collection("Tasks")
                                            .doc(ref
                                                .watch(riverPodHard)
                                                .firebasData[index]["id"])
                                            .update(data);
                                      } else {
                                        Map<String, dynamic> data = {
                                          "title": ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["title"],
                                          "description": ref
                                                  .watch(riverPodHard)
                                                  .firebasData[index]
                                              ["description"],
                                          "date": ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["date"],
                                          "priority": ref
                                              .watch(riverPodHard)
                                              .firebasData[index]["priority"],
                                          "status": "Incompleted"
                                        };
                                        await FirebaseFirestore.instance
                                            .collection("Tasks")
                                            .doc(ref
                                                .watch(riverPodHard)
                                                .firebasData[index]["id"])
                                            .update(data);
                                      }

                                      ref.read(riverPodHard).getFirebaseData();
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: (ref
                                                      .watch(riverPodHard)
                                                      .firebasData[index]
                                                  ["status"] ==
                                              "Completed")
                                          ? Center(
                                              child: Icon(
                                                Icons.check,
                                                size: 14,
                                                color: Colors.green,
                                              ),
                                            )
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget screenType(int index) {
    if (index == 2) {
      
      return filter();
    } else {
      filterData=[];
      return home();
    }
  }

  Widget filter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Filter Tasks",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Priority",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 130,
                    child: DropdownButtonFormField<String>(
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Low",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: ["Low", "Medium", "High"].map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) {
                        taskPriority = value;
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Status",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 145,
                    child: DropdownButtonFormField<String>(
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Compeleted",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: ["Completed", "Incompleted"].map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) {
                        taskStatus = value;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
                minimumSize: WidgetStatePropertyAll(Size(200, 40)),
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 91, 85, 243),
                )),
            onPressed: () {
              filterData = [];
              log("--------------");
              log("$filterData");
              if (taskPriority == null || taskStatus == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select filters")));
              } else {
                for (var value in ref.watch(riverPodHard).firebasData) {
                  if (value["status"] == taskStatus &&
                      value["priority"] == taskPriority) {
                    filterData.add(value);
                  }
                }

                log("$filterData");
              }
              setState(() {});
            },
            child: Text(
              "Apply Filters",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: filterData.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
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
                            filterData[index]["title"],
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            filterData[index]["description"],
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Priority:${filterData[index]["priority"]}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red[400]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Due Date:${filterData[index]["date"]}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue[400]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
