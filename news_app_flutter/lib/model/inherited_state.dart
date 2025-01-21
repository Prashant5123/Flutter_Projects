import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Details extends InheritedWidget{
  int articlesRead;
  int streak;
  String firstName;
  String lastName;
  String imageUrl;
 

  Details({super.key,required this.articlesRead,required this.streak,required this.firstName,required this.lastName,required this.imageUrl, required super.child});

  static Details of(BuildContext context){
     return context.dependOnInheritedWidgetOfExactType<Details>()!;
  }
  
  @override
  bool updateShouldNotify( Details oldWidget) {
   
    return articlesRead!=oldWidget.articlesRead || streak!=oldWidget.streak || firstName!=oldWidget.firstName || lastName!=oldWidget.lastName || imageUrl!=oldWidget.imageUrl;
  }
} 