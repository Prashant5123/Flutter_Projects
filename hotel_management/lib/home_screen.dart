import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> foodType = ["Veg", "Nonveg"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kitchen Katta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),

      body: Column(
        children: [
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: foodType.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(children: [Text(foodType[index])]),
                  ),

                  SizedBox(height: 20),
                ],
              );
            },
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
