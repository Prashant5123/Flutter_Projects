import 'dart:developer';

import 'package:fin_task/image_pick.dart';
import 'package:fin_task/responsive_appbar.dart';
import 'package:fin_task/state_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

class OpenCamera extends StatefulWidget {
  const OpenCamera({super.key});

  @override
  State<OpenCamera> createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  String _imagePath = "";
  final AccountController _accountController = AccountController();
  Future<void> _sendData(BuildContext context, String path) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              Icon(Icons.file_present, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(child: Text("File is getting parsed...")),
            ],
          ),
        );
      },
    );

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://bsaprocess.finanalyz.com/api/pdfparsing'));
      request.files.add(await http.MultipartFile.fromPath('file', path));
      request.fields['bankname'] = "";
      request.fields['accounttype'] = _accountController.accountType.value;
      request.fields['fromwhere'] = "pdf";
      request.fields['odlimit'] = "";
      // (_accountController.accountType.value == "Current")
      //     ? odlimitController.text
      //     : "0";
      request.fields['password'] = "";
      request.fields['work'] = "";
      request.fields['names'] = "";
      // (nameController.text.isEmpty) ? "--" : nameController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        log("In Success");
        _imagePath = "";
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Upload successful"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        log("In Failure");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      Get.back();
      log("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload error: $e")),
      );
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: ResponsiveAppBar(title: "Upload Photo",color: Color.fromARGB(255, 62, 144, 117),),
   
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePick imagePick = ImagePick();
                        _imagePath = await imagePick.openCamera();
                        log("$_imagePath");

                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(Icons.camera_alt_outlined),
                              Text("Capture Image"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: (_imagePath == "")
                          ? Text("No file chosen")
                          : Text(
                              _imagePath.split("/").last,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                    ),
                    (_imagePath != "")
                        ? GestureDetector(
                            onTap: () async {
                              final result = await OpenFile.open(_imagePath);
                            },
                            child: Text(
                              "View",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (_imagePath != "") {
                  _sendData(context, _imagePath);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please capture an image"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 62, 144, 117),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Previous Files",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
