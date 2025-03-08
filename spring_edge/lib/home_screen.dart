import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  bool originPorts = false;
  bool destinationPorts = false;

  List<String> list = [
    "Hard commodities",
    "Soft commodities",
    "Metals",
    "Energy",
    "Agricultural"
  ];

  List<String> containerSize = ["20' Small", "40' Standard", "50' Big"];

  String? selectedCommodity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 234, 248, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Color.from(alpha: 0.498, red: 1, green: 1, blue: 1),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        "Search the best Freight Rates",
                        style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                            color: Color.fromRGBO(33, 33, 33, 1)),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromRGBO(230, 235, 255, 1)),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(1, 57, 255, 1)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                              ),
                            )),
                        onPressed: () {},
                        child: Text(
                          "History",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                            color: Color.fromRGBO(1, 57, 255, 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Container(
                height: 700,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          modelTextField(
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Color.fromRGBO(102, 102, 102, 1),
                                size: 20,
                              ),
                              hintText: "Origin"),
                          SizedBox(
                            width: 24,
                          ),
                          modelTextField(
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Color.fromRGBO(102, 102, 102, 1),
                                size: 20,
                              ),
                              hintText: "Destination")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 120) / 2,
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(
                                      color: Color.fromRGBO(208, 213, 221, 1),
                                      width: 1),
                                  value: originPorts,
                                  onChanged: (bool? value) {
                                    originPorts = value!;
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  "Include nearby origin ports",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.17,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 120) / 2,
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(
                                      color: Color.fromRGBO(208, 213, 221, 1),
                                      width: 1),
                                  value: destinationPorts,
                                  onChanged: (bool? value) {
                                    destinationPorts = value!;
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  "Include nearby destination ports",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.17,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownMenu(
                            width:
                                (MediaQuery.of(context).size.width - 120) / 2,
                            label: SizedBox(child: Text("Commodity")),
                            onSelected: (value) {
                              selectedCommodity = value;
                            },
                            dropdownMenuEntries: list.map(
                              (String item) {
                                return DropdownMenuEntry(
                                    value: item, label: item);
                              },
                            ).toList(),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          SizedBox(
                            height: 56,
                            width:
                                (MediaQuery.of(context).size.width - 120) / 2,
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_month_sharp,
                                  color: Color.fromRGBO(232, 232, 232, 1),
                                ),
                                hintText: "Cut Of Date",
                                hintStyle: GoogleFonts.publicSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.15,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(232, 232, 232, 1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(232, 232, 232, 1)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Text(
                          "Shipment Type :",
                          style: GoogleFonts.publicSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                            color: Color.fromRGBO(33, 33, 33, 1),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          DropdownMenu(
                            width:
                                (MediaQuery.of(context).size.width - 120) / 2,
                            textStyle: GoogleFonts.publicSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.15,
                                color: Color.fromRGBO(102, 102, 102, 1)),
                            label: Text("Container Size"),
                            dropdownMenuEntries: containerSize.map(
                              (String item) {
                                return DropdownMenuEntry(
                                    value: item, label: item);
                              },
                            ).toList(),
                          ),

                          SizedBox(width: 24,),

                          SizedBox(
                            width: (((MediaQuery.of(context).size.width-120)/2)-24)/2,
                            child: TextField(
                                                    
                                decoration: InputDecoration(
                                  
                                  hintText: "No of Boxes",
                                  hintStyle: GoogleFonts.publicSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.15,
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(232, 232, 232, 1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(232, 232, 232, 1)),
                                  ),
                                ),
                              ),
                          ),


                          SizedBox(width: 24,),

                          SizedBox(
                            width: (((MediaQuery.of(context).size.width-120)/2)-24)/2,
                            child: TextField(
                                                    
                                decoration: InputDecoration(
                                  
                                  hintText: "Weight (Kg)",
                                  hintStyle: GoogleFonts.publicSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.15,
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(232, 232, 232, 1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(232, 232, 232, 1)),
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),

                      Row(
                        children: [
                          Icon(Icons.info_outline),
                          Text("To obtain accurate rate for spot rate with guaranteed space and booking, please ensure your container count and weight per container is accurate.")
                        ],
                      ),

                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget modelTextField({required Widget icon, required String hintText}) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 120) / 2,
      height: 56,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
              color: Color.fromRGBO(158, 158, 158, 1)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(232, 232, 232, 1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(232, 232, 232, 1)),
          ),
        ),
      ),
    );
  }
}
