import 'dart:io';
import 'package:get/get.dart';
import 'package:studentswap/utils/App_button_style.dart';
import '../utils/App_text_style.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import 'seller_controller.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatelessWidget{
  const Addproduct({super.key,this.id,
  this.itemname,
  this.condition,
  this.img,
  this.price,
  this.isscaffold = false,
  });
  final String? id;
  final String? itemname;
  final String? price;
  final String? condition;
  final List<dynamic>? img;
  final bool isscaffold;
  @override
  Widget build(BuildContext context){

    final SellerController controller = Get.find<SellerController>();
    final WelcomeController wlcmcontroller = Get.find<WelcomeController>();

     if (controller.isEditing.value && controller.images.isEmpty) {
      controller.images.assignAll(
        (img ?? []).map((e) => File(e)).toList(),
      );
      controller.productname = itemname ?? '';
      controller.price = price ?? '';
      controller.condition = condition ?? '';
    }
    
    Widget content= SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
          height: 120,
          child: Obx(() {
          final imgs = controller.images;
          final hasImages = controller.images.isNotEmpty;
          
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imgs.length + 1,
            physics: hasImages ? const BouncingScrollPhysics() : NeverScrollableScrollPhysics(),  
            itemBuilder: (context, index){
            if (index == imgs.length){
               return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                  horizontal: hasImages ? 12 : (MediaQuery.of(context).size.width - 100) / 2,
                ), 
                    child: InkWell(
                      onTap: controller.imageFuture,
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.add, size: 30),
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                     color: Colors.white,
                     boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                        )
                      ],
                  ),
                child: GestureDetector(
              onTap: () {
              showDialog(
              context: context,
              builder: (context) {
              return Dialog(
              backgroundColor: Colors.black,
              insetPadding: const EdgeInsets.all(16),
               child: Stack(
                children: [
                  InteractiveViewer(
                    child: Image.file(
                     imgs[index],
                      fit: BoxFit.contain,
                    ),
                  ),
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
          },
        );
          },
          onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete image'),
              content: const Text('Do you want to delete this image?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    controller.images.removeAt(index);
                    Get.back();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
                    child: Image.file(
                      imgs[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
          }
          
        )
              ),
        
              SizedBox(height: 16),
              SingleChildScrollView(
                child: Form(
                  key: controller.formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                       padding: const EdgeInsets.all(16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Product Name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.start,),
                        SizedBox(height: 5,),
                        TextFormField(
                          initialValue: controller.productname,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Eg,loreal shampoo',
                             border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.lightBlue)
                          )
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'enter product name';
                            }
                            return null;
                          },
                          onSaved: (value){
                            controller.productname = value!;
                          },
                          
                        ),    
                      SizedBox(height: 16),
                      Text('Price(₹)',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.start),
                        SizedBox(height: 5,),
                      TextFormField(
                        initialValue: controller.price,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Eg,₹500',
                          labelText: '₹',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.lightBlue)
                          )
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty)
                          return 'Enter price';
                        },
                        onSaved: (value){
                          controller.price = value!;
                        },
                      ),
                      SizedBox(height: 16,),
                      Text('Condition',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.start),
                        SizedBox(height: 5,),
                       TextFormField(
                        initialValue: controller.condition,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'In a much stable state',
                           border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.lightBlue)
                          )
                        ),
                        onSaved: (value){
                          controller.condition = value!;
                        },
                       ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
                
              SizedBox(
           width: 350,
          height: 48,
          child: ElevatedButton(
         style: AppButtonStyle.outLinedButtonStyle(onpressing:wlcmcontroller.isButtonActive(ActiveButton.Addproduct) ),
         onPressed: () async{
          wlcmcontroller.setActiveButton(ActiveButton.Addproduct);
          if(controller.formcheck()){
             controller.isEditing.value
                        ? await controller.updateproduct(
                          id!,
                          controller.productname,
                          controller.price,
                          controller.condition,
                          controller.images.map((e) => e.path).toList(),
                        )
                        : await controller.submitprod();
             controller.isEditing.value = false;
          }
        },
        child:  Text(
          controller.isEditing.value ? 'Save Changes' : 'Add Product',
          style: TextStyle(fontSize: 16,
           color: wlcmcontroller.isButtonActive(ActiveButton.Addproduct) ? Colors.white : AppTextStyle.subheading.color ),
        ),
          ),
        ),
        
                ],
              ),
      );
    
       if (isscaffold) {
        return Scaffold(
        appBar: AppBar(
        title: const Text('Edit Product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: content,
    );
  }
      return content;      
  }
}