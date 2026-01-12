import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController{

  final _firebase = FirebaseAuth.instance;

  final formkey = GlobalKey<FormState>();
  
  var userId = '';
  var password = '';

  bool saveForm() {
  final isValid = formkey.currentState?.validate() ?? false;

  if (!isValid) return false;

  formkey.currentState!.save();
  return true;
}

  Future<String?>  getemailwithregisterno(String registerNo) async{
        final query = await  FirebaseFirestore.instance.collection(
          'users'
        ).where('studentId' ,isEqualTo: registerNo).limit(1).get();

        if(query.docs.isEmpty){
          Get.snackbar('Error', 'StudentId not found');
          return null;
        }
        return query.docs.first['email'];
  }
   Future<bool> loginUser() async{                                                                                              
    final isValid = saveForm();
    if(!isValid){
      return false;
    }
    try{
      userId = userId.trim().toUpperCase();
      final mail = await getemailwithregisterno(userId);
      if(mail == null){
        return false;
      }
      
      await _firebase.signInWithEmailAndPassword(
        email: mail, 
        password: password);
        return true;
    } on FirebaseAuthException catch (error){
        if(error.code == 'user-not-found'){
          Get.snackbar('Error', 'User not found');
        }else if(error.code == 'wrong-password'){
          Get.snackbar('Error', 'Password is wrong');
        }
        return false;
    }
   }

  void resetForm() {
    formkey.currentState!.reset();
  }
}