import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatbytes_todo/riverpod.dart';

class FilterTasks extends ConsumerStatefulWidget {
  const FilterTasks({super.key});

  @override
  ConsumerState<FilterTasks> createState() => _FilterTasksState();
}

class _FilterTasksState extends ConsumerState<FilterTasks> {
  String? taskPriority;
  String? taskStatus;
  List filterData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,
        color: Colors.white,),
        backgroundColor: const Color.fromARGB(255, 91, 85, 243),
        title: Text(
          "Filter",
          style: GoogleFonts.poppins(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          return DropdownMenuItem(
                              value: item, child: Text(item));
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
                      width: 131,
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
                          return DropdownMenuItem(
                              value: item, child: Text(item));
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

                filterData=[];
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
                setState(() {
                  
                });
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
                              filterData[index]
                                  ["title"],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                             filterData[index]
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
                          //   Row(
                          //     children: [
                          //       Text(
                          //         "Mark as completed",
                          //         style: GoogleFonts.poppins(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w400,
                          //             color: Colors.grey),
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       GestureDetector(
                          //         onTap: () async {
                          //           if (ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["status"] ==
                          //               "Incompleted") {
                          //             Map<String, dynamic> data = {
                          //               "title": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["title"],
                          //               "description": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["description"],
                          //               "date": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["date"],
                          //               "priority": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["priority"],
                          //               "status": "Completed"
                          //             };
                          //             await FirebaseFirestore.instance
                          //                 .collection("Tasks")
                          //                 .doc(ref
                          //                     .watch(riverPodHard)
                          //                     .firebasData[index]["id"])
                          //                 .update(data);
                          //           } else {
                          //             Map<String, dynamic> data = {
                          //               "title": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["title"],
                          //               "description": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["description"],
                          //               "date": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["date"],
                          //               "priority": ref
                          //                   .watch(riverPodHard)
                          //                   .firebasData[index]["priority"],
                          //               "status": "Incompleted"
                          //             };
                          //             await FirebaseFirestore.instance
                          //                 .collection("Tasks")
                          //                 .doc(ref
                          //                     .watch(riverPodHard)
                          //                     .firebasData[index]["id"])
                          //                 .update(data);
                          //           }

                          //           ref.read(riverPodHard).getFirebaseData();
                          //         },
                          //         child: Container(
                          //           height: 15,
                          //           width: 15,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(2),
                          //               border: Border.all(color: Colors.grey)),
                          //           child: (ref
                          //                       .watch(riverPodHard)
                          //                       .firebasData[index]["status"] ==
                          //                   "Completed")
                          //               ? Center(
                          //                   child: Icon(
                          //                     Icons.check,
                          //                     size: 14,
                          //                     color: Colors.green,
                          //                   ),
                          //                 )
                          //               : null,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                           ],
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
}
