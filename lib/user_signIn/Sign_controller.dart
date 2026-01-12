import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignController extends GetxController{

  final _firebase = FirebaseAuth.instance;
    final formKey = GlobalKey<FormState>();
    var studentId = '';
    var name = '';
    var password = '';
    var email = '';
    
    bool SaveSignForm(){
     final isvalid = formKey.currentState?.validate() ?? false;
     if(!isvalid){
      return false;
     }
     formKey.currentState?.save();
    
     return true;
    }
    Future<bool>  SignUpUser() async{
       final isValid = SaveSignForm();
       if(!isValid){
        return false;   //out of function
       }
       try{
       final usercredential = await _firebase.createUserWithEmailAndPassword(
        email: email,
         password: password);
         
         await FirebaseFirestore.instance.collection('users').doc(usercredential.user!.uid).set(
          {
            'studentId' : studentId,
            'name' : name,
            'email' : email,
            'password' : password
          }
        );
        return true;
       }on FirebaseAuthException catch (error){
          if(error.code == 'email-already-in-use'){
          Get.snackbar('Error', 'Email already in use');
          }else if(error.code  == 'weak-password'){
            Get.snackbar('Error', 'The password is too weak');
          }else if(error.code == 'invalid-email'){
            Get.snackbar('Error', 'Invalid email address');
          }
          return false; 
       }
    }
    void reset(){
      formKey.currentState!.reset();
    }
}