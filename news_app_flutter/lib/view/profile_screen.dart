import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter/controller/local_storage.dart';

import 'package:news_app_flutter/view/home_screen.dart';
import 'package:news_app_flutter/view/login_page.dart';
import 'package:provider/provider.dart';

import '../model/news.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 251, 249),
        appBar: AppBar(
          shadowColor: Colors.grey,
          backgroundColor: Colors.black,
          title: Text(
            "World News",
            style: GoogleFonts.sahitya(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          leading: Image.asset("assets/image.png", color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(Provider.of<News>(context).userData["url"],fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "${Provider.of<News>(context).userData["firstName"]} ${Provider.of<News>(context).userData["lastName"]}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              //article read
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Article Read",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "$articleReadHome",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Streak",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "1",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Divider(),

              Text(
                "Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              GestureDetector(
                onTap: () {
                  LocalStorage.articlesRead=0;
                    Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false, // Remove all previous routes
              );
            
          
                
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Logout",
                      style: GoogleFonts.sahitya(fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.logout_rounded,
                      size: 16,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
