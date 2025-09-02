import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmanagement/state_management.dart';
import 'package:jobmanagement/user_bottom_navigation.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  final UserDetails _userDetailsController = Get.put(UserDetails());

  @override
  void initState() {
    super.initState();
    // listen to search input and filter jobs reactively
    _searchController.addListener(_searchJobs);
  }

  void _searchJobs() {
    String query = _searchController.text.toLowerCase();

    // Update the RxList directly; no setState needed
    _userDetailsController.displayedJobs = _userDetailsController.allJobs.where(
      (job) {
        return (job['title']?.toLowerCase().contains(query) ?? false) ||
            (job['description']?.toLowerCase().contains(query) ?? false) ||
            (job['location']?.toLowerCase().contains(query) ?? false) ||
            (job['postedBy']?.toLowerCase().contains(query) ?? false);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 91, 85, 243),
          title: _isSearching
              ? Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Search...",
                      hintStyle: GoogleFonts.poppins(fontSize: 18),
                      border: InputBorder.none,
                    ),
                  ),
                )
              : Text(
                  "Jobs",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
                ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              color: Colors.white,
              onPressed: () {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  // Reset displayedJobs to show all
                  _userDetailsController.displayedJobs = List.from(
                    _userDetailsController.allJobs,
                  );
                } else {
                  _isSearching = true;
                }
                setState(() {}); // only to toggle the search bar
              },
            ),
          ],
        ),
      ),
      // body: Obx(() {
      //   return ListView.builder(
      //     itemCount: _userDetailsController.displayedJobs.length,
      //     itemBuilder: (context, index) {
      //       var job = _userDetailsController.displayedJobs[index];
      //       return Card(
      //         margin: EdgeInsets.all(8),
      //         child: ListTile(
      //           title: Text(job['title']),
      //           subtitle: Text(job['description']),
      //           trailing: Text("₹${job['salary']}"),
      //         ),
      //       );
      //     },
      //   );
      // }),
      bottomNavigationBar: UserBottomNavigation().userBottomNavigation(
        context: context,
      ),
    );
  }
}
