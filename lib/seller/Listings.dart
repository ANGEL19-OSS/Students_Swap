import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studentswap/seller/Addproduct.dart';
import 'package:studentswap/seller/seller_controller.dart';
import 'package:get/get.dart';

class Listings extends StatelessWidget{
  const Listings({super.key});

  Widget build(BuildContext context){
    final SellerController controller = Get.find<SellerController>();
    return Obx(
      ()=> ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index)
         {
        final prod = controller.products[index];
        if(controller.isLoading.value ){
             return Center(
              child: CircularProgressIndicator(),
            );
        }
       return Padding(
         padding: const EdgeInsets.all(16.0),
         child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadiusGeometry.circular(16),
           side: BorderSide(style: BorderStyle.solid),
          ),
          child: Row(
           children: [
             Container(
                padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        )
                      ],
                     ),
              child: GestureDetector(
                onTap: () {
                   showDialog(context: context,
                    builder: (context) {
                       return Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: const EdgeInsets.all(16),
                        child: Stack(
                          children: [
                             ProductImageSlider( images: prod.prod_images, size: 60, ),
                             Positioned(
                              top: 8,
                             right: 8,
                             child: IconButton(
                             icon: const Icon(Icons.close, color: Colors.white),
                           onPressed: () => Get.back(),
                    ),
                  )
                          ],
                          
                        ),
                       );
                    }
                     );
                },
                child: ProductImageSlider(
                 images: prod.prod_images,
                 size: 60,
                  ),
              ),      
             ),
             SizedBox(width: 8,),
             Column(
              children: [
                Text(prod.productname, style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937), // dark gray (not pure black)
                 )),
                 SizedBox(height: 3,),
                 Text("₹  ${prod.price.toString()}", style:  const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 28, 168, 117), // calm blue
                  )),
              ],
             ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
           children: [
           const SizedBox(width: 30),
      
             ElevatedButton(
        style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(36, 36),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        print('onlcicked');
         controller.images.clear();
         controller.productname = '';
         controller.price = '';
         controller.condition = '';
         
         controller.isEditing.value =  true;

          Get.to (() => Addproduct(
          id: prod.id,
          itemname: prod.productname,
          price: prod.price,
          condition: prod.condition, 
          img:prod.prod_images,
          isscaffold: true, ));
         
      },
      child: const Icon(Icons.edit, size: 18, color: Colors.blue),
    ),
      
        SizedBox(width: 6),
        ElevatedButton(
        style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(36, 36),
        backgroundColor: Colors.red.shade50,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
        onPressed: () {
          showDialog(context: context, builder:(context){
            return AlertDialog(
              title: Text('Delete this item'),
              content: Text('Do you want to delete this product from your listings'),
              actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  controller.products.removeAt(index);
                  controller.deleteproduct(prod.id);
                  Get.back();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
            );
          }
           );
        },
       child: const Icon(Icons.delete, size: 18, color: Colors.red),
          ),
         ],
         )
      
           ],
          ),
         ),
       );
        }
      ),
    );
  }
}

class ProductImageSlider extends StatelessWidget {
  final List<dynamic> images;
  final double size;

  const ProductImageSlider({
    super.key,
    required this.images,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        width: size,
        height: size,
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_not_supported),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final path = images[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: kIsWeb
                ? Image.network(
                    path,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  ),
          );
        },
      ),
    );
  }
}