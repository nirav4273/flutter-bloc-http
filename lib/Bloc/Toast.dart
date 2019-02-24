import 'package:flutter/material.dart';

class Toast{
  static showToast(BuildContext context,String message){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}