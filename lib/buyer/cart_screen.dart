import 'package:flutter/material.dart';
import 'package:studentswap/buyer/buyer_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class CartScreen extends StatelessWidget{
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
    final size = MediaQuery.of(context).size;

     final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(   //after adding bottom navigation need to change the logic here 
       leading:IconButton(onPressed: (){
        Get.back();
       }, icon: Icon(Icons.arrow_back)),
       title: Text('Items in the cart',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Obx(()=>
         Column(
           children: [
             Expanded(
               child: ListView.builder(
                physics: BouncingScrollPhysics(),
                 itemCount: controller.cartproducts.length,
                 itemBuilder: (context, index){
                   final cartitems = controller.cartproducts[index];
                        return Column(
                          children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(12),
                               child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.blue),
                               ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Container(
                                           height: 80 ,
                                           width: 80,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.all(Radius.circular(5)),
                                             boxShadow: [
                                             BoxShadow(
                                             color: Colors.black.withOpacity(0.08),
                                             blurRadius: 6,
                                             offset: const Offset(0, 3),
                                         ),
                                        ],
                                           ),
                                            padding: EdgeInsets.all(8),
                                            child: Image.file(File(cartitems.image),
                                            fit: BoxFit.cover,),
                                         ),
                                         SizedBox(width: width*0.1),
                                         Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                              Text(cartitems.product_name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:15 )),
                                              SizedBox(height: 8,),
                                              Text( "₹${cartitems.price}",style: TextStyle(color: const Color.fromARGB(255, 27, 176, 57),fontWeight: FontWeight.bold,fontSize: 13),)
                                           ],
                                         )
                                       ],
                                     ),
                                    Row(                        
                                     children: [
                                       TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF4CB6E6),
                                          side: BorderSide( color: Colors.blue,width: 2)
                                        ),
                                        onPressed: (){}, child: Text('swap',style: TextStyle(color: Colors.white),)),
                                        IconButton(
                                   icon: Icon(Icons.delete, size: 18, color: Colors.red),
                                   onPressed: () {
                                    controller.cartproducts.removeAt(index);
                                   controller.removeFromCart(cartitems.id);
                                    },
                                   )
                                     ],
                                   )
                                   ],
                                 ),
                               ),
                             ),
                            
                          ],                       
                        );
                 }),
             ),
              Container(
                padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    )
                  ),
                  onPressed: (){}, child:Text(
                  "Total: ₹${controller.totalPrice}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), ),               
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CB6E6)
                  ),
                  child: Text("Checkout",style: TextStyle(color: Colors.white),),
                ),
                              ],
                             ),
              )
         ],
         ),
          
          ),
                         
      );
    
  }
}