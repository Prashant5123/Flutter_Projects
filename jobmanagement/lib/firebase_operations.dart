import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jobmanagement/state_management.dart';

class FirebaseOperations {
  final UserDetails _userDetailsController = Get.put(UserDetails());
  
  void getAllJobs({required String email, required String panel}) async {
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot response = await firebaseFirestore
        .collection(panel)
        .doc(email)
        .collection("Jobs")
        .get();
    for (var value in response.docs) {
      Map<String, dynamic> jobData = value.data() as Map<String, dynamic>;
      jobData["id"] = value.id;
      _userDetailsController.allJobs.add(jobData);
    }
  }
}
