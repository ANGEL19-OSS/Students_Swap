import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController{

  final formkey = GlobalKey<FormState>();

  var room_no = '';
  var dept_name = '';
  var year = '';
  var ph_no ='';
  File? fileimage;


  bool saveform(){
    final isvalid = formkey.currentState?.validate() ??  false;

    if(isvalid){
      return true;
    }
    formkey.currentState!.save();
    return false;
  }
  void resetFform(){
    formkey.currentState!.reset();
  }
  void pickImage() async {
    final pickedimage = await  ImagePicker().pickImage(source: ImageSource.camera,maxWidth: 150,imageQuality: 50);
    if(pickedimage == null){
      return;
    }
    fileimage = File(pickedimage.path);
  }
}