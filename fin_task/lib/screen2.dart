import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fin_task/image_pick.dart';
import 'package:fin_task/open_camera.dart';
import 'package:fin_task/responsive_appbar.dart';
import 'package:fin_task/state_management.dart';
import 'package:fin_task/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final AccountController _accountController = Get.put(AccountController());
  TextEditingController nameController = TextEditingController();
  TextEditingController filePasswordController = TextEditingController();
  TextEditingController odlimitController = TextEditingController();
  File? _selectedFile;
  String? accountType;
  String startDate = "Enter Start Date";
  String endDate = "Enter End Date";
  String imagePath = "";
  String _path = "";

  List<String> bankNames = [
    "SBI_Bank",
    "HDFC_Bank",
    "AXIS_Bank",
    "KOTAK_Bank",
    "YES_Bank",
    "ICICI_Bank"
  ];

  List<Widget> fileStatus = <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Upload Files"),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("See Transactions"),
    )
  ];
  List<bool> selectedFileStatus = [false, true];

  List<String> accountNumberList = [];
  List<String> uniqueAccountNumberList = [];

  List<String> accountTypes = ["Current", "Savings", "Buisness"];
  String? bankName;
  bool isChecked = false;

  String? password;

  List existingFiles = [];

  Future _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;

      final fileExtension = filePath.split('.').last.toLowerCase();

      if (fileExtension == 'pdf') {
        setState(() {
          _selectedFile = File(filePath);
          imagePath = "";
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please choose a valid PDF file.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void openDatePicker(String datePosition, BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2010), lastDate: DateTime(2050));
    String formatedDate = DateFormat("dd-MM-yyyy").format(date!);
    if (datePosition == "startDate") {
      setState(() {
        startDate = formatedDate;
      });
    } else {
      setState(() {
        endDate = formatedDate;
      });
    }
  }

  Future<void> sendData(BuildContext context, String path) async {
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
      request.fields['bankname'] = bankName!;
      request.fields['accounttype'] = _accountController.accountType.value;
      request.fields['fromwhere'] = "pdf";
      request.fields['odlimit'] =
          (_accountController.accountType.value == "Current")
              ? odlimitController.text
              : "0";
      request.fields['password'] = password!;
      request.fields['work'] = "5";
      request.fields['names'] =
          (nameController.text.isEmpty) ? "--" : nameController.text;

      var response = await request.send();

      Get.back();

      if (response.statusCode == 200) {
        log("In Success");
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload successful")),
        );
      } else {
        log("In Failure");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${response.statusCode}")),
        );
      }

      setState(() {
        _selectedFile = null;
        bankName = null;
        accountType = null;
        isChecked = false;
      });

      filePasswordController.clear();
      nameController.clear();
      odlimitController.clear();
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
  void initState() {
    super.initState();
    setState(() {
      uniqueAccountNumberList = _accountController.accountNumbers;
    });
  }

  // void accounList() async {
  //   setState(() {
  //     isLoading=true;
  //   });
  //   for (int i = 0; i < _accountController.accounNumbers.length; i++) {
  //     accountNumberList
  //         .add(_accountController.accounNumbers[i]["accountDetails"]);
  //   }

  //   setState(() {
  //     uniqueAccountNumberList = accountNumberList.toSet().toList();
  //   });

  //   setState(() {
  //     isLoading=false;
  //   });
  // }
  String? selectedAccountNumber;
  @override
  void dispose() {
    nameController.dispose();
    odlimitController.dispose();
    filePasswordController.dispose();
    _selectedFile = null; // free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(title: "BSA ${_accountController.accountType.value}",color: Color.fromARGB(255, 62, 144, 117),),
   
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ToggleButtons(
                  isSelected: selectedFileStatus,
                  fillColor: const Color.fromARGB(255, 240, 240, 240),
                  selectedColor: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < selectedFileStatus.length; i++) {
                        selectedFileStatus[i] = i != index;
                        log("${selectedFileStatus[i]}");
                      }
                    });

                    if (selectedFileStatus[0]) {
                      imagePath = "";
                      _selectedFile = null;
                    }
                  },
                  children: fileStatus,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              (selectedFileStatus[0] == false)
                  ? Column(
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
                                  onTap: () {
                                    _pickFile(context);
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("Choose File"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: (_selectedFile == null &&
                                          imagePath == "")
                                      ? Text("No file chosen")
                                      : (_selectedFile != null &&
                                              imagePath == "")
                                          ? Text(
                                              basename(
                                                _selectedFile!.path,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            )
                                          : Text(
                                              imagePath.split("/").last,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(OpenCamera());
                          },
                          child: Row(
                            children: [
                              Text(
                                "Proceed with camera",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  // decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 14,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            hintText: "Enter Inhouse Company Name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                            value: bankName,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            hint: Text("Select Your Bank"),
                            items: bankNames.map(
                              (String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                bankName = value;
                              });
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        (_accountController.accountType.value == "Current")
                            ? TextField(
                                controller: odlimitController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintText: "Enter odlimit",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "* Click on check box to enter file password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                        (isChecked == true)
                            ? TextField(
                                controller: filePasswordController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintText: "Enter File Password",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if ((_selectedFile != null || imagePath != "") &&
                                  bankName != null) {
                                if (isChecked) {
                                  password = filePasswordController.text;
                                } else {
                                  password = "--";
                                }

                                if (_selectedFile == null && imagePath != "") {
                                  _path = imagePath;
                                } else {
                                  _path = _selectedFile!.path;
                                }

                                sendData(context, _path);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Please complete all required fields.')),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 62, 144, 117),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  "Upload",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        DropdownSearch<String>(
                          selectedItem: selectedAccountNumber,
                          items: (filter, infiniteScrollProps) =>
                              uniqueAccountNumberList,
                          itemAsString: (String? item) => item ?? '',
                          onChanged: (value) {
                            setState(() {
                              selectedAccountNumber = value;
                            });
                          },
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                              labelText: "Select Account Number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: "Search account number...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please select an account'
                              : null,
                        ),

                        // DropdownButtonFormField(
                        //   isExpanded: true,
                        //   decoration: InputDecoration(
                        //       label: Text("Select Account Number",
                        //         style: TextStyle(
                        //           overflow: TextOverflow.ellipsis
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(),
                        //       focusedBorder: OutlineInputBorder()),
                        //   items: uniqueAccountNumberList.map(
                        //     (String item) {
                        //       return DropdownMenuItem(
                        //         value: item,
                        //         child: Text(item,
                        //           style: TextStyle(
                        //           overflow: TextOverflow.ellipsis
                        //         ),
                        //         ),
                        //       );
                        //     },
                        //   ).toList(),
                        //   onChanged: (value) {},
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                openDatePicker("startDate", context);
                              },
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 50) /
                                        2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          startDate,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(Icons.calendar_month_rounded)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                openDatePicker("endDate", context);
                              },
                              child: Container(
                                height: 50,
                                width:
                                    (MediaQuery.of(context).size.width - 50) /
                                        2,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          endDate,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(Icons.calendar_month_rounded)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(TransactionHistory());
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 62, 144, 117),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
