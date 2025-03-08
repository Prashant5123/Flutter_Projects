
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app_flutter/controller/loader.dart';
import "package:intl/intl.dart";


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailSiginController = TextEditingController();
  final TextEditingController _passwordSiginController =
      TextEditingController();
  final TextEditingController _comPasswordSiginController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

 
  bool _isObscure=true;
  bool _isComObscure=true;
 bool _isLoading=false;
  XFile? selectedFile;

  // FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          
          surfaceTintColor: Colors.white,
          leading: Icon(null),
        
        ),
      ),
      body: Stack(
        children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
         
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign In",
                          style: GoogleFonts.quicksand(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
        
                        Center(
                          child: GestureDetector(
                            onTap: ()async{
                               ImagePicker imagePicker=ImagePicker();
                               selectedFile=await imagePicker.pickImage(source: ImageSource.gallery);
                               setState(() {
                                 
                               });
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle
                              ),
                              child: (selectedFile==null)?Icon(Icons.person,size: 100,):Image.file(File(selectedFile!.path),fit: BoxFit.cover,),
                              
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller:_lastNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailSiginController,
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
                          obscureText: (_isObscure)?true:false,
                          controller: _passwordSiginController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  if (_isObscure) {
                                    _isObscure = false;
                                    setState(() {});
                                  } else {
                                    _isObscure = true;
                                    setState(() {});
                                  }
                                },
                                child: (_isObscure)
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
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
                        TextFormField(
                          obscureText: (_isComObscure)?true:false,
                          controller: _comPasswordSiginController,
                          onFieldSubmitted: (value) {
                            if (value != _passwordSiginController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password did not match")));
                                  setState(() {
                                    
                                  });
                                }
                          },
                         
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                          
                            suffixIcon: GestureDetector(
                              onTap:(){
                                if(_isComObscure){
                                  _isComObscure=false;
                                  setState(() {
                                    
                                  });
                                }else{
                                  _isComObscure=true;
                                  setState(() {
                                    
                                  });
                                }
                              },
                              child: (_isComObscure)?Icon(Icons.visibility_off) :Icon(Icons.visibility)
                            ),
                            labelText: "Comform Password",
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
                           if(  selectedFile!=null && _firstNameController.text.trim().isNotEmpty && _lastNameController.text.trim().isNotEmpty && _emailSiginController.text.trim().isNotEmpty && _passwordSiginController.text.trim().isNotEmpty && _comPasswordSiginController.text.trim().isNotEmpty && _passwordSiginController.text.trim()==_comPasswordSiginController.text.trim()  ){
        
                            try{
        
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailSiginController.text, password: _passwordSiginController.text);
                            setState(() {
                              _isLoading=true;
                            });
                             DateTime now = DateTime.now();
                             String date=DateFormat.MMMMEEEEd().format(now);
                             log(date);
                             
                            await FirebaseStorage.instance
                                .ref()
                                .child("${now}_${_emailSiginController.text}")
                                .putFile(File(selectedFile!.path));
                            String url = await FirebaseStorage.instance
                                .ref()
                                .child("${now}_${_emailSiginController.text}")
                                .getDownloadURL();
        
                             Map<String,dynamic> data={
                              "firstName":_firstNameController.text,
                              "lastName":_lastNameController.text,
                              "email":_emailSiginController.text,
                              "url":url
                            };
                            await FirebaseFirestore.instance.collection("user").doc(_emailSiginController.text).set(data);
                               Navigator.pop(context);
        
                               setState(() {
                                 _isLoading=false;
                               });
        
                            }on FirebaseAuthException catch (error){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!)));
                            }
                           }else{
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid data")));
                           }
                          },
                          child: Text(
                            "Sign In",
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
                                "have an Account",
                                style: GoogleFonts.quicksand(
                                    fontSize: 23, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 30,
                                  width: 60,
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 7, 39, 221)),
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
         if (_isLoading) Loader.circularLoading()
        
        ]
      ),
    );
  }
}
