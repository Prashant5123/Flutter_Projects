import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomPdfViewer extends StatelessWidget {
  final String path;
  final String fileName;
  const CustomPdfViewer({
    super.key,
    required this.path,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 30,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(255, 91, 85, 243),
          title: Text(
            fileName,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
        ),
      ),

      body: SafeArea(child: SfPdfViewer.network(path!)),
    );
  }
}
