import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SellerController  extends GetxController{
   final _firebase = FirebaseFirestore.instance;
  RxInt selectedTab = 1.obs;        
  RxList<File> images = <File>[].obs;
  String productname ='';
  String price ='';
  String condition ='';
  final formkey = GlobalKey<FormState>();
  void setTab(int idx){
    selectedTab.value = idx;
  }
  
  bool formcheck(){
    final isvalid = formkey.currentState?.validate() ?? false;
     if(!isvalid) return false;
     return true;
  }
  Future<bool> submitprod()async{
    final isValid = formcheck();
    if(!isValid) return false;
    try{
      await _firebase.collection('products').doc().set({
         'productname' : productname,
         'price' : price,
         'condition' : condition,
      });
      return true;
    }on FirebaseException catch(error){
         print(error.message);
         return false;
    }
  }
  void resetForm(){
    formkey.currentState?.reset();
  }
  void imageFuture()async{
    var image = await ImagePicker().pickImage(source: ImageSource.camera ,imageQuality : 50);
    if(image!=null){
    images.add(File(image.path));
    }
  }
  

}