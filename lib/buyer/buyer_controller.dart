import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:studentswap/models/CartModel.dart';
import 'package:studentswap/models/userdatamodel.dart';
import 'package:studentswap/seller/seller_controller.dart';
import 'dart:async';
import '../models/ProductModel.dart';
import '../models/ProfileModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class BuyerController extends GetxController{
  final _firebase = FirebaseFirestore.instance;
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  var allproducts = <Product>[].obs;
  var allprofile = <Profile>[].obs;
  var sellerprofile = Rxn<Profile>(); //reactive 
  var usersfrbuy = <Userdata>[].obs;
  var username = Rxn<String>();   //reactive variable
  var cartproducts = <CartModel>[].obs;  //reactive int sum
  var addedtocart = false.obs;
  var isScaffold = false.obs;
  RxInt selectedpage = 0.obs;
  TextEditingController messageController = TextEditingController();
  final List<String> images = [
       'assets/assets/pd_1.jpeg',
       'assets/assets/pd_2.gif',
       'assets/assets/pd_3.jpeg',
       'assets/assets/pd_4.jpeg',
  ];
   Timer? _timer;

  @override
  void onInit() {
    super.onInit();
      pageController = PageController();
     fetchAllproducts();
     startAutoSlide();
     fetchuserprofile();
     fetchallsusers();
     getcartItems();
    
    
  }
  void changepage(int index){
      selectedpage.value = index;
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
  Future<void> fetchuserprofile()async{
    try{
     final snapshot =  await  _firebase.collection('profile').get();
       final profiles = snapshot.docs.map((e) => Profile.fromDoc(e)).toList();
       allprofile.assignAll(profiles);
     print('fetched  all profiles');
    }catch(e){
      print('no profile loading..');
    }
  }
  


  Profile? fetchProductProfile(String sellerId)  {
      sellerprofile.value =  allprofile.firstWhere((e) => sellerId == e.id ,    
       );
    }

    Future<void> fetchallsusers()async{
      try{
      final snapshot = await _firebase.collection('users').get();
      final users = snapshot.docs.map((doc) => Userdata.fromDoc(doc)).toList();
      usersfrbuy.assignAll(users);
      }catch(e){
        print('no users found');
      }
    }
    void fetchusername(String sellerId){
      print(username.value);
      username.value= usersfrbuy.firstWhere((e) => sellerId == e.id).username;   //gettting the user via sellerId
      
    }


  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  } 
   final user = FirebaseAuth.instance.currentUser!.uid;
  //add to cart 
  Future<void> Addtocart( String id ,String name , String price,String seller_id,String seller_number ,String image)async{
    try{
      final docref =   await _firebase.collection('users').doc(user).collection('cart').doc(id);
          final doc = await docref.get();
             
          if(!doc.exists){         //avoids overwriting 
         await docref.set({        //the 
         'product_name' : name,
         'product_price' : price,
         'seller_id' : seller_id,
         'seller_number' :seller_number,
         'product_image' : image,      
    });
    } else{
      Get.snackbar("Already Added", "This item is already in cart",backgroundColor:Color(0xFF4CB6E6),colorText: Colors.white);
    }
    }catch(e){
      print('Error adding cart items... $e');
    }
  }
  int get totalPrice =>
    cartproducts.fold(
      0,
      (sum, item) =>
          sum + (int.parse(item.price)),
    );

  void getcartItems() {
    print('getting..cart times');
      _firebase
      .collection('users')
      .doc(user)
      .collection('cart')
      .snapshots()
      .listen((snapshot) {         //a real time listener instead of future
        final cartitems =
            snapshot.docs.map((e) => CartModel.fromDoc(e)).toList();
        print(cartitems.length);
        cartproducts.assignAll(cartitems);
      });
   }
   Future<void> removeFromCart(String id) async{
    try{
         await _firebase.collection('users').doc(user).collection('cart').doc(id).delete();
    }catch(e){
      print('Error removing product from cart');
    }
   }
   String chatId ='';
   Future<void> buyerchat(String sellerId,String productId) async{
         List<String> ids = [user, sellerId];
          ids.sort();

          chatId = "${ids[0]}_${ids[1]}_$productId";

          DocumentSnapshot snapshot =  await _firebase.collection('chats').doc(chatId).get();
          if(!snapshot.exists){
            await _firebase.collection('chats').doc(chatId).set({
                'participants' : ids,   //chatscreen list generation
                'productId' : productId, 
                'lastMessage': '',
                'lastMessageTime': FieldValue.serverTimestamp(),
            });
          }
       }
     Future<void> sendmessage() async{
     if(messageController.text.isEmpty)return;
     String text = messageController.text.trim();
      try{
        await _firebase.collection('chats').doc(chatId).collection('messages').add({
          'senderId' : user,
          'text' : text,
          'timestamp' : FieldValue.serverTimestamp(),
        }
        );
        await _firebase.collection('chats').doc(chatId).update({
       'lastMessage': text,
       'lastMessageTime': FieldValue.serverTimestamp(),
  });
        messageController.clear();  
      }catch(e){
        print("error inputing messages $e");
      }
   }

}
