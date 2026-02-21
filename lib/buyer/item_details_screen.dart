import 'dart:io';

import 'package:studentswap/buyer/cart_screen.dart';

import 'buyer_controller.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import '../models/ProductModel.dart';
import '../models/ProfileModel.dart';

class ItemDetailsScreen extends StatelessWidget{
    const ItemDetailsScreen ({required this.product,super.key});

  final Product product;

   @override
  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
  
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final seller = controller.sellerprofile.value;
      final alreadyInCart =
                  controller.cartproducts.any((item) => item.id == product.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        actions: [
          IconButton(onPressed: (){
            Get.to(() => CartScreen());
          }, icon: Icon(Icons.shopping_cart))
        ],
        title: Text('Information',style: TextStyle(fontSize: width * 0.045,),
        
        textAlign: TextAlign.center),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 242, 242),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),   //a bouncing scroll view
            
        child: ConstrainedBox(
        constraints: BoxConstraints(
       minHeight: MediaQuery.of(context).size.height,
    ),
    child: IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: height * 0.35,
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: product.prod_images.length ,
                    padEnds: false,   //does not stop
                    itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.file(
                              File(product.prod_images[index]),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(onPressed: (){
                              //add to favorites
                            }, icon: Icon(Icons.favorite_border, color: Colors.lightBlueAccent,)),
                            )
                            ]                  
                          )
                        ),
                      );
                    }),
                ),
               ),
                SizedBox(height: height * 0.02),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow:  [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.productname,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.055,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Ratings: 4.0',
                                      style: TextStyle(
                                        fontSize: width * 0.032,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(255, 247, 181, 14),
                                      ),
                                    ),
                                      Icon(Icons.star,color:const Color.fromARGB(255, 247, 181, 14) ,)
                                  ],
                                ),
                              ],
                                                    ),
                                     
                              SizedBox(height: height * 0.015),
                             Text('₹${product.price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.05,
                                  color: Colors.green[700],
                          ), ),
                                  ],
                                 ),
                  ),
                ),
             
               SizedBox(height: height * 0.02),

                // Description
                Container(
                  width: double.infinity,
                   decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow:  [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                                    Text(
                    product.condition ,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),)
                      ],
                    ),
                  ),             
                ),               
                SizedBox(height: height * 0.02),
                Obx(()=>
                   Container(                
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
               decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(16),
              boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
                 ),
              ],
              ),
  
  child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start, 
    children: [
         Text('seller details',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(    
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            foregroundImage: seller?.image != null
                ? FileImage(File(seller!.image!))
                : null,
            child: seller?.image == null
                ? const Icon(Icons.person, size: 30, color: Colors.grey)
                : null,
          ),
      
          const SizedBox(width: 16),
          /// Seller Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.username.value ?? "Unknown Seller",  //hrere a reactive widget so wrap with obx
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ///  Verified Badge
                    Icon(
                      Icons.verified,
                      color: Colors.green.shade600,
                      size: 18,
                    ),
                  ],
                ),
      
                const SizedBox(height: 6),
                /// Department + Year
                Text(
                  "${seller?.dept_name ?? ""} dept • ${seller?.year ?? ""} yr",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
      
                const SizedBox(height: 4),     
                /// Room Number
                Text(
                  "Room: ${seller?.room_no ?? "-"}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
            
        ],
      ),
    ],
  ),
  ),
                ),
                
                Container(
                    padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                   vertical: height * 0.015,
                   ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CB6E6),
                            foregroundColor: Colors.white,
                             shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.03),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.018,
                                    ),
                                  ),
                            onPressed: (){ 
                                if(!alreadyInCart){ 
                               _showSnackbar(context, 'Adding to cart...'); }                      
                               controller.Addtocart( product.id, product.productname, product.price,product.sellerId,product.sellerNumber,
                               product.prod_images[0]
                               );
                            }, child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                            'Add to Cart',
                           ),
                          ),),
                        ),
                        SizedBox(width: width * 0.02,),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CB6E6),
                            foregroundColor: Colors.white,
                             shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.03),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.018,
                                    ),
                          ),
                            onPressed: (){}
                          , child: Text('Swap')),
                        )
                    ],
                  ),
                ),
            ]
           ),
           
        ),
      ),
      )
      )

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