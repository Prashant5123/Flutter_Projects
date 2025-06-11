import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),


      body: Column(
        children: [
          ListView.builder(itemBuilder: (context,index){
            return Column(
              children: [
                
              ],
            );
          })
        ],
      ),
    );
  }
}