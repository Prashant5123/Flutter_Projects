import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ImagePick {
   XFile? selectedFile;
   DateTime dateTime=DateTime.now();

 Future<String> openCamera() async {
    ImagePicker imagePicker = ImagePicker();

    final file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file != null) {
      selectedFile = file;
       String path = await convertImageToPdf(selectedFile);
       return path;
    }

    return "";

  
  }

 Future<String> convertImageToPdf(XFile? selectedFile) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(await selectedFile!.readAsBytes());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Image(image),
        ),
      ),
    );

    final outputDir = await getTemporaryDirectory();
    final outputFile = File("${outputDir.path}/image_$dateTime.pdf");
    await outputFile.writeAsBytes(await pdf.save());

    log("PDF saved to ${outputFile.path}");

    return outputFile.path;

    // Open the PDF
    //final result = await OpenFile.open(outputFile.path);
  }
}
