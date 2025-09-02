import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserDetails extends GetxController {
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var panel = "".obs;
  var jobIndex = 0.obs;
  var adminJobIndex = 0.obs;
  List allJobs = <Map<String, dynamic>>[].obs;
  List appliedUsers = <Map<String, dynamic>>[].obs;
  List userAppliedJobs = <Map<String, dynamic>>[].obs;
  List displayedJobs=<Map<String, dynamic>>[].obs;

  void fillUserDetail({
    required String firstName,
    required String lastName,
    required String email,
    required String panel,
  }) {
    this.firstName.value = firstName;
    this.lastName.value = lastName;
    this.email.value = email;
    this.panel.value = panel;
  }

  void getAllJobs() async {
    allJobs.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot response = await firebaseFirestore
        .collection("Admin")
        .doc("prashant@gmail.com")
        .collection("Jobs")
        .get();
    for (var value in response.docs) {
      Map<String, dynamic> jobData = value.data() as Map<String, dynamic>;
      jobData["id"] = value.id;
      allJobs.add(jobData);
    }
  }

  void getUserAllJobs() async {
  
    allJobs.clear();
    await getuserAppliedJobs();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot response = await firebaseFirestore
        .collection("Admin")
        .doc("prashant@gmail.com")
        .collection("Jobs")
        .get();
    for (var value in response.docs) {
      Map<String, dynamic> jobData = value.data() as Map<String, dynamic>;
      jobData["id"] = value.id;
      bool alreadyApplied = userAppliedJobs.any(
        (job) => job["id"] == jobData["id"],
      );

      if (!alreadyApplied) {
        allJobs.add(jobData);
      }
    }
  }

  void getappliedUsersJobs({required String id}) async {
    appliedUsers.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot response = await firebaseFirestore
        .collection("Admin")
        .doc("prashant@gmail.com")
        .collection("Jobs")
        .doc(id)
        .collection("applied_users")
        .get();
    for (var value in response.docs) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      appliedUsers.add(data);
    }
  }

  Future getuserAppliedJobs() async {
    userAppliedJobs.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot response = await firebaseFirestore
        .collection("User")
        .doc(email.value)
        .collection("applied_jobs")
        .get();
    for (var value in response.docs) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;

      userAppliedJobs.add(data);
    }
    log("${userAppliedJobs}");
  }
}
