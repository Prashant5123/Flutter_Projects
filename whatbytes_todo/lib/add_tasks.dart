import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whatbytes_todo/local_data.dart';
import 'package:whatbytes_todo/riverpod.dart';

class AddTasks extends ConsumerStatefulWidget {
  const AddTasks({super.key});

  @override
  ConsumerState<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends ConsumerState<AddTasks> {
  List<String> priorityList = ["Low", "Medium", "High"];
  String? priority;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();


  void submitTask()async{
    if(_titleController.text.trim().isNotEmpty &&_descriptionController.text.trim().isNotEmpty &&_dateController.text.trim().isNotEmpty && priority!=null){
      
      Map<String,dynamic> data={
        "title":_titleController.text,
        "description":_descriptionController.text,
        "date":_dateController.text,
        "priority":priority,
        "status":"Incomplete"
      };
      log("---------------------------");
      log(SessionData.emailId!);
      await FirebaseFirestore.instance.collection("user").doc(SessionData.emailId).collection("tasks").add(data);
      // log("Task added");
      
      setState(() {
        ref.read(riverPodHard).getFirebaseData();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task added successfully.")));
    }else{
        setState(() {
        ref.read(riverPodHard).getFirebaseData();
      });

      log("${ref.read(riverPodHard).firebasData}");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 91, 85, 243),
              ),
              height: 90,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Enter Title",
                          hintStyle:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          hintText: "Enter Description",
                          hintStyle:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Enter Due Date",
                        hintStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Select Priority",
                        hintStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
                          minimumSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width,40)),
                          backgroundColor: WidgetStatePropertyAll( Color.fromARGB(255, 91, 85, 243),)
                        ),
                          onPressed: () {
                            submitTask();
                          },
                          child: Text(
                            "Add Task",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
