import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:fin_task/responsive_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  TextEditingController filterController = TextEditingController();
  List<Map> existingAllFiles = [
    {
      "Ser_No.": "1",
      "Date": "12",
      "Account_Number": "123",
      "Transaction_Type": "Debit",
      "Mode_Of_Transactions": "cash",
      "Particulars": "cash",
      "Category": "Fuel",
      "Description": "ganeshservicestationhyderabadin-04/04/18 05:30:40/7989",
      "Debits": "200",
      "Credits": "0",
      "Current_Balance": "200000"
    },
    {
      "Ser_No.": "1",
      "Date": "12",
      "Account_Number": "123",
      "Transaction_Type": "Debit",
      "Mode_Of_Transactions": "cash",
      "Particulars": "cash",
      "Category": "Fuel",
      "Description": "ganeshservicestationhyderabadin-04/04/18 05:30:40/7989",
      "Debits": "200",
      "Credits": "0",
      "Current_Balance": "200000"
    },
    {
      "Ser_No.": "1",
      "Date": "12",
      "Account_Number": "123",
      "Transaction_Type": "Debit",
      "Mode_Of_Transactions": "cash",
      "Particulars": "cash",
      "Category": "Fuel",
      "Description": "ganeshservicestationhyderabadin-04/04/18 05:30:40/7989",
      "Debits": "200",
      "Credits": "0",
      "Current_Balance": "200000"
    },
    {
      "Ser_No.": "1",
      "Date": "12",
      "Account_Number": "123",
      "Transaction_Type": "Debit",
      "Mode_Of_Transactions": "cash",
      "Particulars": "cash",
      "Category": "Fuel",
      "Description": "ganeshservicestationhyderabadin-04/04/18 05:30:40/7989",
      "Debits": "200",
      "Credits": "0",
      "Current_Balance": "200000"
    },
    {
      "Ser_No.": "1",
      "Date": "12",
      "Account_Number": "123",
      "Transaction_Type": "Debit",
      "Mode_Of_Transactions": "cash",
      "Particulars": "cash",
      "Category": "Fuel",
      "Description": "ganeshservicestationhyderabadin-04/04/18 05:30:40/7989",
      "Debits": "200",
      "Credits": "0",
      "Current_Balance": "200000"
    },
    {
      "Ser_No.": "1",
      "Date": "12",
      "Account_Number": "123",
      "Transaction_Type": "Debit",
      "Mode_Of_Transactions": "cash",
      "Particulars": "cash",
      "Category": "Fuel",
      "Description": "ganeshservicestationhyderabadin-04/04/18 05:30:40/7989",
      "Debits": "200",
      "Credits": "0",
      "Current_Balance": "200000"
    }
  ];

  List<Map> existingUPIFiles = [
    {
      "Date": "5/2/2025",
      "Mode_Of_Transaction": "UPI",
      "Particulars": "Misc. Expenses",
      "Category": "Misc. Expenses",
      "Description": "mb-upi debit 06700450- 25/02/19 21:08:18",
      "Amount": "20"
    },
    {
      "Date": "5/2/2025",
      "Mode_Of_Transaction": "UPI",
      "Particulars": "Misc. Expenses",
      "Category": "Misc. Expenses",
      "Description": "mb-upi debit 06700450- 25/02/19 21:08:18",
      "Amount": "20"
    },
    {
      "Date": "5/2/2025",
      "Mode_Of_Transaction": "UPI",
      "Particulars": "Misc. Expenses",
      "Category": "Misc. Expenses",
      "Description": "mb-upi debit 06700450- 25/02/19 21:08:18",
      "Amount": "20"
    },
    {
      "Date": "5/2/2025",
      "Mode_Of_Transaction": "UPI",
      "Particulars": "Misc. Expenses",
      "Category": "Misc. Expenses",
      "Description": "mb-upi debit 06700450- 25/02/19 21:08:18",
      "Amount": "20"
    },
    {
      "Date": "5/2/2025",
      "Mode_Of_Transaction": "UPI",
      "Particulars": "Misc. Expenses",
      "Category": "Misc. Expenses",
      "Description": "mb-upi debit 06700450- 25/02/19 21:08:18",
      "Amount": "20"
    },
  ];
  List<bool> selectedTransaction = [false, true];
  List<Widget> transactionType = <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("All Transactions"),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("UPI Transactions"),
    )
  ];

  Future<void> generatePdf(List<dynamic> data, BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      final font =
          pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Table.fromTextArray(
            headers: [
              'Date',
              'Mode_Of_Transaction',
              'Particulars',
              "Category",
              "Description",
              "Amount"
            ],
            data: data
                .map((item) => [
                      item['Date'].toString(),
                      item['Mode_Of_Transaction'],
                      item['Particulars'],
                      item['Category'],
                      item['Description'],
                      item['Amount'],
                    ])
                .toList(),
            cellStyle: pw.TextStyle(font: font),
            headerStyle:
                pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
          ),
        ),
      );

      // Save to Downloads folder
      Directory? downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        downloadsDir = await getExternalStorageDirectory();
      }

      final filePath = "${downloadsDir!.path}/user_data.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to $filePath')),
      );

      log("$filePath");

      // Open the file
      await OpenFile.open(filePath);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  Future<void> generateExcelAndSave(
      List<dynamic> data, BuildContext context) async {
    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      final excel = Excel.createExcel(); // Automatically creates one sheet
      final Sheet sheet = excel['User Data'];

      // Add header
      sheet.appendRow([
        TextCellValue('Date'),
        TextCellValue('Mode_Of_Transaction'),
        TextCellValue('Particulars'),
        TextCellValue('Category'),
        TextCellValue('Description'),
        TextCellValue('Amount'),
      ]);

      // Add data
      for (var item in data) {
        sheet.appendRow([
          TextCellValue(item['Date'].toString()),
          TextCellValue(item['Mode_Of_Transaction'].toString()),
          TextCellValue(item['Particulars'].toString()),
          TextCellValue(item['Category'].toString()),
          TextCellValue(item['Description'].toString()),
          TextCellValue(item['Amount']
              .toString()), // Or use IntCellValue(...) if it's an int
        ]);
      }

      // Get Downloads folder path
      Directory? downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        downloadsDir = await getExternalStorageDirectory();
      }

      final filePath = "${downloadsDir!.path}/user_data.xlsx";
      final file = File(filePath);

      // Save Excel
      await file.writeAsBytes(excel.encode()!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Excel file saved to $filePath')),
      );

      // Open the file
      await OpenFile.open(filePath);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: ResponsiveAppBar(title: "Transaction History",color: Color.fromARGB(255, 62, 144, 117),),
      // appBar: AppBar(
      //   title: Text("Transaction History"),
      //   centerTitle: true,
      //   backgroundColor: const Color.fromARGB(255, 62, 144, 117),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ToggleButtons(
                    isSelected: selectedTransaction,
                    fillColor: const Color.fromARGB(255, 240, 240, 240),
                    selectedColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < selectedTransaction.length; i++) {
                          selectedTransaction[i] = i != index;
                        }
                      });
                    },
                    children: transactionType),
              ),
              SizedBox(
                height: 20,
              ),
              (selectedTransaction[0] == false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange[100]),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transaction Summary",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(
                                          255, 184, 179, 247)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "204",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Number of Transactions",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.green[200]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "₹ 12,20,186.96",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Credit Amount",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.pink[50]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "₹ 7,76,490.16",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Debit Amount",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Transaction Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromARGB(
                                        255, 62, 144, 117)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Text(
                                    "Download Pdf",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                               
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromARGB(
                                        255, 62, 144, 117)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Text(
                                    "Download Excel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text("Ser No.")),
                              DataColumn(label: Text("Date")),
                              DataColumn(label: Text("Account Number")),
                              DataColumn(label: Text("Transaction Type")),
                              DataColumn(label: Text("Mode Of Transactions")),
                              DataColumn(label: Text("Particulars")),
                              DataColumn(label: Text("Category")),
                              DataColumn(label: Text("Description")),
                              DataColumn(label: Text("Debits")),
                              DataColumn(label: Text("Credits")),
                              DataColumn(label: Text("Current Balance")),
                            ],
                            rows: existingAllFiles.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data["Ser_No."] ?? "")),
                                DataCell(Text(data["Date"] ?? "")),
                                DataCell(Text(data["Account_Number"] ?? "")),
                                DataCell(Text(data["Transaction_Type"] ?? "-")),
                                DataCell(
                                    Text(data["Mode_Of_Transactions"] ?? "")),
                                DataCell(Text(data["Particulars"] ?? "")),
                                DataCell(Text(data["Category"] ?? "")),
                                DataCell(Text(data["Description"] ?? "-")),
                                DataCell(Text(data["Debits"] ?? "")),
                                DataCell(Text(data["Credits"] ?? "")),
                                DataCell(Text(data["Current_Balance"] ?? "")),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "UPI Transactions",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Filter by Names/Category:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: filterController,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "All",
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.filter_alt_outlined)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red[100]),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Debits",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "₹ 72,100.00",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green[100]),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Credits",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "₹ 720.00",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                generatePdf(existingUPIFiles, context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromARGB(
                                        255, 62, 144, 117)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Text(
                                    "Download Pdf",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                 generateExcelAndSave(existingUPIFiles, context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromARGB(
                                        255, 62, 144, 117)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Text(
                                    "Download Excel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Debit Transactions",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text("Date"),
                                ),
                                DataColumn(
                                  label: Text("Mode Of \nTransaction"),
                                ),
                                DataColumn(
                                  label: Text("Particulars"),
                                ),
                                DataColumn(
                                  label: Text("Category"),
                                ),
                                DataColumn(
                                  label: Text("Description"),
                                ),
                                DataColumn(
                                  label: Text("Amount"),
                                ),
                              ],
                              rows: existingUPIFiles.map((data) {
                                return DataRow(cells: [
                                  DataCell(Text(data["Date"] ?? "")),
                                  DataCell(
                                      Text(data["Mode_Of_Transaction"] ?? "")),
                                  DataCell(Text(data["Particulars"] ?? "")),
                                  DataCell(Text(data["Category"] ?? "")),
                                  DataCell(Text(data["Description"] ?? "")),
                                  DataCell(Text(data["Amount"] ?? "")),
                                ]);
                              }).toList()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Credit Transactions",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text("Date"),
                                ),
                                DataColumn(
                                  label: Text("Mode Of \nTransaction"),
                                ),
                                DataColumn(
                                  label: Text("Particulars"),
                                ),
                                DataColumn(
                                  label: Text("Category"),
                                ),
                                DataColumn(
                                  label: Text("Description"),
                                ),
                                DataColumn(
                                  label: Text("Amount"),
                                ),
                              ],
                              rows: existingUPIFiles.map((data) {
                                return DataRow(cells: [
                                  DataCell(Text(data["Date"] ?? "")),
                                  DataCell(
                                      Text(data["Mode_Of_Transaction"] ?? "")),
                                  DataCell(Text(data["Particulars"] ?? "")),
                                  DataCell(Text(data["Category"] ?? "")),
                                  DataCell(Text(data["Description"] ?? "")),
                                  DataCell(Text(data["Amount"] ?? "")),
                                ]);
                              }).toList()),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
