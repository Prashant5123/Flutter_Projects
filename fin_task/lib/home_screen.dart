import 'package:fin_task/responsive_appbar.dart';
import 'package:fin_task/screen2.dart';
import 'package:fin_task/state_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AccountController _accountController=Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: ResponsiveAppBar(title: "Finanalyz",color: const Color.fromARGB(255, 62, 144, 117),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),


          GestureDetector(
            onTap: (){
               _accountController.changeAccount("Savings");

               _accountController.getSavingAccountNumbers("savings");
               Get.to(Screen2());
            },
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 62, 144, 117)
              ),
              child: Center(
                child: Text(
                  "BSA \n Savings",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                  
                ),
              ),
            ),
          ),

          SizedBox(
            height: 40,
          ),


           GestureDetector(
            onTap: () {
              _accountController.changeAccount("Current");

               _accountController.getSavingAccountNumbers("current");
               Get.to(Screen2());
   
            },
             child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 62, 144, 117)
              ),
              child: Center(
                child: Text(
                  "BSA \n Current",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                  
                ),
              ),
                       ),
           )
        ],
      ),
    );
  }
}
