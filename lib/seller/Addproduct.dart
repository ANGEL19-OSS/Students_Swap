import 'dart:io';
import 'package:get/get.dart';
import 'seller_controller.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatelessWidget{
  const Addproduct({super.key});
  @override
  Widget build(BuildContext context){

    final SellerController controller = Get.find<SellerController>();
   
    return Column(
         children: [
          Expanded(
            child: Obx(()=> ListView.builder(
              itemCount: controller.images.length,
              itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
               children: [ 
                 Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.file(
                    controller.images[index],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                 ),
                   Positioned(
                    top: 4,
                    right: 4,
                    child :
                    FloatingActionButton(
                    mini: true,
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                      ),
                       backgroundColor: Colors.white,
                      onPressed: () {
                      controller.imageFuture();
                   },
                   child: Icon(Icons.add, color: Colors.black),
                    ),
                   )
               ],
                ),
            );
            })
            ),
          ),
          SizedBox(height: 10,),
          Form(
            key: controller.formkey,
            child: Column(
              children: [
                  Text('Product Name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Eg,loreal shampoo',
                  border: InputBorder.none,
                ),
                onSaved: (value){
                  controller.productname = value!;
                },
                validator: (value){
                  if(value == null){
                    return 'enter product name';
                  }
                  return null;
                },
              ),    
            SizedBox(height: 10),
            Text('Price(₹)',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Eg,₹500',
                border: InputBorder.none,
              ),
              onSaved: (value){
                controller.price = value!;
              },
            ),
            SizedBox(height: 10,),
            Text('Condition',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
             TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'In a much stable state',
                border: InputBorder.none,
              ),
              onSaved: (value){
                controller.condition = value!;
              },
             ),
              ]
            ),
          )
            ],
          );
          
         
  }
}