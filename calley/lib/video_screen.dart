import 'package:calley/custom_widgets.dart';
import 'package:calley/home_screen.dart';
import 'package:calley/session_data.dart';
import 'package:calley/state_management.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/bP4U-L4EHcg?si=Hft4Jh-3rS-0jpxK',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 250, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 94,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(37, 99, 235, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromRGBO(203, 213, 225, 1)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      color: Color.fromRGBO(15, 23, 42, 0.04),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image.asset("assets/png/profile .png"),

                    SizedBox(width: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomWidgets.customText(
                          text: "Hello ${SessionData.username}",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        CustomWidgets.customText(
                          text: "Calley Personal",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 357,
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Color.fromRGBO(30, 51, 101, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          'If you are here for the first time then ensure that you have uploaded the list to call from calley Web Panel hosted on https://app.getcalley.com',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 256,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color.fromRGBO(14, 176, 29, 1)),
                    ),
                    child: Icon(
                      FontAwesomeIcons.squareWhatsapp,
                      color: Color.fromRGBO(14, 176, 29, 1),
                      size: 30,
                    ),
                  ),

                  SizedBox(width: 20),

                  // ElevatedButton(onPressed: (){}, child:Text("Gvcxxv")),
                  Expanded(
                    child: CustomWidgets.customElevatedButton(
                      text: "Start Calling Now",
                      fun: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
