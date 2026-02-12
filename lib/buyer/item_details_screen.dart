import 'dart:io';

import 'buyer_controller.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import '../models/ProductModel.dart';

class ItemDetailsScreen extends StatelessWidget{
    const ItemDetailsScreen ({required this.product,super.key});

  final Product product;

  Widget build(BuildContext context){
     final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final BuyerController controller = Get.find<BuyerController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
        ],
        title: Text('Information',style: TextStyle(fontSize: width * 0.045,),
        
        textAlign: TextAlign.center),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
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
          SizedBox(height: 10,),
            Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.055,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            '4.0',
                            style: TextStyle(
                              fontSize: width * 0.032,
                              color: const Color.fromARGB(255, 247, 181, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.star)
                        ],
                      ),
                    ),
        ],
      ),
        ]
      ),
      );
    
  }
}