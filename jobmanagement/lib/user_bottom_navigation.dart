import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobmanagement/applied_jobs.dart';
import 'package:jobmanagement/user_home_screen.dart';
import 'package:jobmanagement/profile_screen.dart.dart';

int selectedPage = 0;
int previousPage = 0;

class UserBottomNavigation {
  Widget userBottomNavigation({required BuildContext context}) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 91, 85, 243),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.black,
      currentIndex: selectedPage,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        previousPage = selectedPage;
        for (int i = 0; i < 3; i++) {
          if (i == index) {
            selectedPage = i;
          }
        }

        screenType(selectedPage, context);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
       
        BottomNavigationBarItem(icon: Icon(Icons.save), label: "Applied Jobs"),
         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }

  void screenType(int i, BuildContext context) {
    if (i == 0 && previousPage != 0) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>UserHomeScreen()));
     
    } else if (i == 1 && previousPage != 1) {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AppliedJobs()));
    } else if (i == 2 && previousPage != 2) {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProfileScreen()));
    }
  }
}
