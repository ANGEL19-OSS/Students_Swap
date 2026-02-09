import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:studentswap/seller/ProductModel.dart';

class SellerController  extends GetxController{
  final _firebase = FirebaseFirestore.instance;
  RxInt selectedTab = 0.obs;        
  RxList<File> images = <File>[].obs;
  String productname ='';
  String price ='';
  String condition ='';
  var isLoading = false.obs;
  var isEditing = false.obs;
  var isSetImage = false.obs;

  var products = <Product>[].obs;      //declaring a reactive list 

late Profile profile;                 //declaring here use later
Userdata? user;
  String? pickedprofimg;


  final formkey = GlobalKey<FormState>();
  void onInit(){
    super.onInit();
    fetchproducts();
    fetchuserprofile();
    fetchuser();
  }
  void setTab(int idx){
    selectedTab.value = idx;

    if(idx == 1){
      isEditing.value == false;
      resetForm();
      images.clear();
    }
  }
  
  bool formcheck(){
    final isvalid = formkey.currentState?.validate() ?? false;
     if(!isvalid){ return false;}
     formkey.currentState?.save();
     return true;
  }
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> submitprod() async{
    print('called');
    print("LOGGED IN UID: $uid");
    final profileDoc = await FirebaseFirestore.instance
    .collection('profile')
    .doc(uid)
    .get();
    final sellernumber = profileDoc['ph_no'];
    try{
      await _firebase.collection('products').doc().set({
         'productname' : productname,
         'price' : price,
         'condition' : condition,
         'prod_images' : images.map((e) => e.path).toList(),
         'sellerId': uid,
        'sellerNumber': sellernumber,

      });
      print('successfull');
      
    }on FirebaseException catch(error){
         print(error.message);
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

  
  Future<void> fetchproducts() async{
        isLoading.value = true;
        print('fetching...');
        try{
               final snapshot = await _firebase.collection('products').where('sellerId' , isEqualTo: uid).get();
               print("DOC COUNT: ${snapshot.docs.length}");

               final product = snapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
              products.assignAll(product);
              print('fetched');
        }catch (e){
          print("error loading products,$e");
        }finally{
          isLoading.value=  false;
        }
  }
  Future<void> deleteproduct(String id) async{
         try{
          _firebase.collection('products').doc(id).delete();
         }catch (e){
          print('error deleting $e');
         }
  }

  //edit the product
  

  Future<void> updateproduct(String id, String name, String price, String cond, List<dynamic> items)async{
         try{
           _firebase.collection('products').doc(id).update({
              'productname' : name,
              'price' : price,
              'condition' : cond,
              'prod_images' : items,
           });
           print('updated');
         }catch(e){
          print('error updating $e');
         }
  }
  //profile methods
  Future<void> fetchuserprofile()async{
    try{
     final snapshot =  await  _firebase.collection('profile').doc(uid).get();
     if(snapshot.exists){
      profile = Profile.fromDoc(snapshot);

     }
     print('fetched profile');
    }catch(e){
      print('no profile loading..');
    }
  }
  void changeprofile() async{
   var image =  await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50,); 
   pickedprofimg =  image!.path;
   }


   Future<void> fetchuser()async{
    try{
      final snapshot= await _firebase.collection('users').doc(uid).get();
       if(snapshot.exists){
        user = Userdata.fromDoc(snapshot);
       }
       print('user fetched');
    }catch(e){
      print('failed to fetch user');
    }
   }

   Future<void> UpdateProfile(String username , String studentId,String phone,String year,
    String room_no,String image, String dept_name
    )async{
      try{
          _firebase.collection('users').doc(uid).update({
            'name' : username,
            'studentId' : studentId
          });
      }catch(e){
        print('update..proff');
      }
      try{
        _firebase.collection('profile').doc(uid).update({
          'image' : image,
          'ph_no' : phone,
          'room_no' : room_no,
          'year' : year,
          'dept_name' : dept_name
          
        });
      }catch(e){

      }
   }

}