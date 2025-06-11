import 'package:fin_task/components/textfields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _reEnterPasswordController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
           FocusScope.of(context).unfocus(); 
        },
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                            
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/png/Logo.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
              
                    SizedBox(
                      height: 20,
                    ),
                
                
                    CustomWidgets.customTextField( controller:_nameController , label: Text("Enter Your Name")),
                            
                            
                    SizedBox(
                      height: 20,
                    ),
                
                
                    CustomWidgets.customTextField( controller:_emailController , label: Text("Enter Email")),
                            
                     SizedBox(
                      height: 20,
                    ),
                            
                            
                    CustomWidgets.customTextField( controller:_passwordController, label: Text("Enter Password"),),
              
                    SizedBox(
                      height: 20,
                    ),
                
                
                    CustomWidgets.customTextField( controller:_reEnterPasswordController , label: Text("Re-Enter Password")),
                            
                            
                    SizedBox(
                      height: 20,
                    ),
                            
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 62, 144, 117)//const Color.fromARGB(255, 40, 125, 73)
                      ),
                            
                      child: Center(
                        child: Text("Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                            
                            
                    SizedBox(
                      height: 20,
                    ),
                            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text("Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
              
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}