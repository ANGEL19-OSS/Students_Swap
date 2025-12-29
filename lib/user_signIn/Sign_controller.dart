import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController{

    final formKey = GlobalKey<FormState>();
    var studentId = '';
    var name = '';
    var password = '';
    var email = '';
    
    bool SaveSignForm(){
     final isvalid = formKey.currentState?.validate() ?? false;
     if(isvalid){
      return true;
     }
     return false;
    }
    void reset(){
      formKey.currentState!.reset();
    }
}