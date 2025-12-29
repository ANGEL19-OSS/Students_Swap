import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  final formkey = GlobalKey<FormState>();
  
  var username = '';
  var password = '';

   bool saveForm() {
  final isValid = formkey.currentState?.validate() ?? false;

  if (!isValid) return false;

  formkey.currentState!.save();
  // add to the database

  return true;
}

  void resetForm() {
    formkey.currentState!.reset();
  }
}