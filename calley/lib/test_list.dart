import 'dart:convert';
import 'dart:developer';

import 'package:calley/custom_drawer.dart';
import 'package:calley/custom_widgets.dart';
import 'package:calley/session_data.dart';
import 'package:calley/state_management.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TestList extends StatefulWidget {
  const TestList({super.key});

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  Map<String, dynamic> result = {};
  double pending = 0.0;
  double done = 0.0;
  double schedule = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getUserData();
    // });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
     result = Provider.of<StateManagement>(context).result;
    pending = result["pending"].toDouble();
    done = result["called"].toDouble();
    schedule = result["rescheduled"].toDouble();
  }

  // Future<void> getUserData() async {
  //   log("${SessionData.id}");
  //   Uri url = Uri.parse(
  //     "https://mock-api.calleyacd.com/api/list/68626fb697757cb741f449b9",
  //   );

  //   http.Response response = await http.get(url);

  //   result = jsonDecode(response.body);

  // pending = result["pending"].toDouble();
  // done = result["called"].toDouble();
  // schedule = result["rescheduled"].toDouble();

  //   setState(() {});
  //   log("$result");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 250, 255),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: Icon(Icons.dehaze_outlined),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                  ),

                  SizedBox(width: 10),

                  CustomWidgets.customText(
                    text: "Dashboard",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  Spacer(),
                  Icon(Icons.headset_mic_outlined),

                  SizedBox(width: 20),

                  Icon(Icons.notifications),
                ],
              ),
              SizedBox(height: 20),

              Expanded(
                child: Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Test List",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                
                            Row(
                              children: [
                                Text(
                                  "50",
                                  style: GoogleFonts.inter(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(37, 99, 235, 1),
                                  ),
                                ),
                
                                SizedBox(width: 5),
                
                                Text(
                                  "CALLS",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                
                        Container(
                          height: 65,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(37, 99, 235, 1),
                          ),
                          child: Center(
                            child: Text(
                              "${SessionData.username![0]}",
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 300,
                width: 300,
                child: PieChart(
                  key: ValueKey(pending + done + schedule),
                  swapAnimationDuration: Duration(milliseconds: 300),
                  swapAnimationCurve: Curves.easeOut, // animation style
                  PieChartData(
                    sectionsSpace: 6, // gap between segments
                    centerSpaceRadius: 100, // inner hole
                    startDegreeOffset: -90, // start from top

                    sections: [
                      PieChartSectionData(
                        value: pending,
                        color: Colors.orange,
                        radius: 30,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: done,
                        color: Colors.blue,
                        radius: 30,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: schedule,
                        color: Colors.purple,
                        radius: 30,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLabelBox(
                    barColor: Color.fromRGBO(250, 171, 60, 1),
                    color: Color.fromRGBO(254, 240, 219, 1),
                    textColor: Colors.black,
                    title: "Pending",
                    value: pending,
                    callsColor: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  _buildLabelBox(
                    barColor: Color.fromRGBO(14, 176, 29, 1),
                    color: Color.fromRGBO(221, 252, 224, 1),
                    textColor: Colors.black,
                    title: "Done",
                    value: done,
                    callsColor: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  _buildLabelBox(
                    barColor: Color.fromRGBO(78, 27, 217, 1),
                    color: Color.fromRGBO(243, 238, 254, 1),
                    textColor: Colors.black,
                    title: "Schedule",
                    value: schedule,
                    callsColor: Colors.grey,
                  ),
                ],
              ),
              Spacer(),

              CustomWidgets.customElevatedButton(
                text: "Star Calling Now",
                fun: () {},
                width: double.infinity,
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),

      drawer: CustomDrawer.customDrawer(context),
    );
  }
}

Widget _buildLabelBox({
  required Color color,
  required Color textColor,
  required String title,
  required double value,
  required Color callsColor,
  required Color barColor,
}) {
  return Expanded(
    child: Container(
      width: 110,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 55,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
    
              Row(
                
                children: [
                  Text(
                    "${value.toInt()}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
    
                  Text(
                    "Calls",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
