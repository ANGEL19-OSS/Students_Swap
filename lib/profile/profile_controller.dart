import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController{
  final firebase = FirebaseFirestore.instance;
  final formkey = GlobalKey<FormState>();

  var room_no = '';
  var dept_name = '';
  var year = '';
  var ph_no ='';
  File? fileimage;
  var upi_id ='';


  bool saveform(){
    final isvalid = formkey.currentState?.validate() ??  false;

    if(!isvalid){
      return false;
    }
    formkey.currentState!.save();
    return true;
  }
  Future<bool> profileform() async{
     final isValid = saveform();
     if(!isValid){
      return false;
     }
     final uid = FirebaseAuth.instance.currentUser!.uid;
     try{
      await firebase.collection('profile').doc(uid).set(
        {
          'room_no' : room_no,
          'dept_name' : dept_name,
          'year' : year,
          'ph_no' : ph_no,
          'image' :fileimage?.path,
          'upi_id' :upi_id
        }
      );
      return true;
     } on FirebaseException catch (error){
      print(error.code);
      print(error.message);
      return false;
     }
  }
  void resetform(){
    formkey.currentState!.reset();
  }
  bool isValidUpi(String upi) {
  final RegExp upiRegex =
      RegExp(r'^[a-zA-Z0-9.\-_]{2,}@[a-zA-Z]{2,}$');

  return upiRegex.hasMatch(upi);
}
  void pickImage() async {
    final pickedimage = await  ImagePicker().pickImage(source: ImageSource.camera,maxWidth: 150,imageQuality: 50);
    if(pickedimage == null){
      return;
    }
    fileimage = File(pickedimage.path);
  }
}