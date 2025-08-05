import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class PdfUpload extends StatefulWidget {
  const PdfUpload({super.key});

  @override
  State<PdfUpload> createState() => _PdfUploadState();
}

class _PdfUploadState extends State<PdfUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
          color: Color.fromRGBO(0, 0, 0, 1),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 20,
            // ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Text(
                "Upload Bank Statement",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(51, 51, 51, 1)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Text(
                "Upload Your Bank Statement for Fast Approval",
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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        size: 25,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "click here",
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(25, 118, 210, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: " to upload your file",
                                style: GoogleFonts.poppins(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                      Text(
                        "Supported Format: pdf",
                        style: GoogleFonts.poppins(
                          color: Color.fromRGBO(120, 118, 118, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesome.file_pdf_solid,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Axis_bank.pdf",
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "uploaded successfully",
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            Spacer(),

           
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(120, 118, 118, 1),
                  borderRadius: BorderRadius.circular(6)
                ),
              
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                            "Next",
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


              SizedBox(
              height: 150,
            ),



         
          ],
        ),
      ),
    );
  }
}
