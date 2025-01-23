

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news_app_flutter/view/home_screen.dart';
import 'package:news_app_flutter/view/signup_page.dart';
import 'package:provider/provider.dart';

import '../model/news.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreen();
}

class _LoginScreen extends State {
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController = TextEditingController();
  bool isObscure=true;




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        surfaceTintColor:Colors.white ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      height: 240,
                      width: 250,
                      child: Image(
                        image: AssetImage("assets/loginpage.webp"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.quicksand(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailLoginController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordLoginController,
                        obscureText:(isObscure)? true:false,
                        
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap:(){
                              if(isObscure){
                                isObscure=false;
                                setState(() {
                                  
                                });
                              }else{
                                isObscure=true;
                                setState(() {
                                  
                                });
                              }
                            },
                            child:(isObscure)?Icon(Icons.visibility_off) :Icon(Icons.visibility),
                          ),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(340, 30),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async{
                          if(_emailLoginController.text.trim().isNotEmpty && _passwordLoginController.text.trim().isNotEmpty ){
                            try{
                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailLoginController.text, password:_passwordLoginController.text);

                              DocumentSnapshot response= await FirebaseFirestore.instance.collection("user").doc(_emailLoginController.text).get();

                           

                            Map  data=response.data() as Map;
                            Provider.of<News>(context,listen: false).changeUserData(data) ;

                             
                              
                              //log("$data");
                              
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomeScreen()));

                            }on FirebaseAuthException catch (error){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!)));
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid data")));
                          }
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          height: 1,
                          width: 300,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Don't have an Account",
                              style: GoogleFonts.quicksand(
                                  fontSize: 23, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {

                                _passwordLoginController.clear();
                                _emailLoginController.clear();
                                
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
                              },
                              child: SizedBox(
                                height: 30,
                                width: 60,
                                child: Text(
                                  "Sign in",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          const Color.fromARGB(255, 7, 39, 221)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
