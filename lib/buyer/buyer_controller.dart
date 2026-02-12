import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:studentswap/models/ProductModel.dart';

class BuyerController extends GetxController{
  final _firebase = FirebaseFirestore.instance;
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  var allproducts = <Product>[].obs;
  final List<String> images = [
       'assets/assets/pd_1.jpeg',
       'assets/assets/pd_2.gif',
       'assets/assets/pd_3.jpeg',
       'assets/assets/pd_4.jpeg',
  ];
   Timer? _timer;

  @override
  void onInit() {
      pageController = PageController();
     fetchAllproducts();
     startAutoSlide();
    super.onInit();
    
  }
   
  void startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
       if (!pageController.hasClients) return;
      if (currentPage.value < images.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }  
  void onPageChanged(int index) {
    currentPage.value = index;
  }
  Future<void> fetchAllproducts()async{
        try{
         var snapshot =  await _firebase.collection('products').get();
         print("Docs length: ${snapshot.docs.length}");

        final product = snapshot.docs.map((e) =>Product.fromDoc(e)).toList();
        allproducts.assignAll(product);
        
        }catch(e){
          print('error fetching allproduct.. $e');
        }
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  } 
}
