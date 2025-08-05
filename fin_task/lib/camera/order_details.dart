import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(51, 51, 51, 1)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
          color: Color.fromRGBO(0, 0, 0, 1),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 20,
            // ),

            // Row(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Icon(
            //       Icons.arrow_back_ios_new,
            //       color: Color.fromRGBO(0, 0, 0, 1),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 27),
            //   child: Text(
            //     "Image Capture ",
            //     style: GoogleFonts.poppins(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w500,
            //         color: Color.fromRGBO(51, 51, 51, 1)),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Text(
                "Please enter the below details to continue.",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(120, 118, 118, 1)),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Text(
                "Customer Name",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: TextField(
                cursorColor: Color.fromRGBO(120, 118, 118, 1),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(120, 118, 118, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(120, 118, 118, 1)))),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(120, 118, 118, 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Proceed",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
