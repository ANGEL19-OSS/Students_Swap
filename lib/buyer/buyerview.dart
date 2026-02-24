import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentswap/buyer/buyer_controller.dart';
import 'package:studentswap/buyer/cart_screen.dart';
import 'package:studentswap/buyer/item_details_screen.dart';
import 'package:studentswap/seller/seller_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../seller/Profile.dart';
import 'package:get/get.dart';

class Buyerview extends StatelessWidget{
  const Buyerview({super.key});

  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    final uid = FirebaseAuth.instance.currentUser!.uid;
    Future<String> getusername()async{
       var doc1 =  await  FirebaseFirestore.instance.collection('users').doc(uid).get();
       return doc1['name'];
    }
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: getusername(), builder: (context, snapshot){
            if(!snapshot.hasData){
              return  Text('loading...');
            }else{
              return  Text("Welcome, ${snapshot.data}");
            }
        }),
      ),
   body:  
   
    Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       SizedBox(
        height: 200,
         child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 20),
         child: PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          itemCount: controller.images.length,
          padEnds: false,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  controller.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity
                ),
              ),
            );
          },
           ),
         ),
       ),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16.0),
         child: Text('Featured Products', 
         style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),
         textAlign: TextAlign.left,
         ),
       ),
      const SizedBox(height: 10,),             
      Expanded(
      child: controller.allproducts.isEmpty
          ? Center(
            child: CircularProgressIndicator(),
            )
          : GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: controller.allproducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {

                final prd = controller.allproducts[index];
                  print("Image path: ${prd.prod_images[0]}");
                  final alreadyInCart =
                  controller.cartproducts.any((item) => item.id == prd.id);

                return GestureDetector(
                  onTap: () {
                    Get.to(
                  () => ItemDetailsScreen(product: prd),
                     binding: BindingsBuilder(() {
                     final controller = Get.put(BuyerController());
                     controller.fetchProductProfile(prd.sellerId);
                     controller.fetchusername(prd.sellerId);
                  }),
                );

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        // 🔹 Product Image
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              
                              child: Image.file(                  //if data/0/  local path and not http path                           
                                     File(prd.prod_images[0]),                               
                                fit: BoxFit.cover,
                                width: double.infinity,
                                
                                 errorBuilder: (context, error, stackTrace) {
                              return 
                               const Icon(Icons.broken_image);
                              
                               },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [                    
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      prd.productname,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                        '4.0',
                                        style: TextStyle(
                                         fontSize: width * 0.032,
                                          color: const Color.fromARGB(255, 247, 181, 14),
                                          fontWeight: FontWeight.w500,
                                         ),
                                          ),
                                        Icon(Icons.star, color:const Color.fromARGB(255, 247, 181, 14) ,)                                             , 
                                      ],
                                    ),
                                  ],
                                ),
                                             
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹${prd.price}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                    ElevatedButton                                   
                                      ( 
                                      style:ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 88, 193, 241),
                                        foregroundColor: Colors.white,
                                       // minimumSize: Size(10, 15),
                                         shape: RoundedRectangleBorder(
                                             borderRadius:
                                      BorderRadius.circular(width * 0.03),                             
                                        ),
                                      ) ,
                                      onPressed: 
                                    (){ 
                                      if(!alreadyInCart) {   
                                      _showSnackbar(context, 'Adding to cart...');}  
                                      controller.Addtocart(prd.id, prd.productname, prd.price, prd.sellerId, prd.sellerNumber, prd.prod_images[0]);
                                      controller.addedtocart.value = true;
                                      
                                    }, child: Icon(Icons.shopping_cart))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    ),
  ],
),
    );
   

    
  }
  
      void _showSnackbar(BuildContext context ,String message) {      //moved the method out build
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.45, // center vertically
        left: 40,
        right: 40,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1779A9),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

}