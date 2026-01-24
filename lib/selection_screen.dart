import 'package:flutter/material.dart';
import 'package:studentswap/seller/sellerview.dart';
import 'package:studentswap/utils/App_button_style.dart';
import 'package:studentswap/utils/App_text_style.dart';
import 'package:get/get.dart';
import 'package:studentswap/welcome/welcome_controller.dart';

class SelectionScreen  extends StatelessWidget{
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context){
    final WelcomeController selectionwlcm = Get.find<WelcomeController>();
    return Scaffold(
      body : Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/assets/Selection_bg.png'),
            SizedBox(height: 20,),
            Text('Choose your path',style: AppTextStyle.heading),
            SizedBox(height: 10,),
            Obx(()=> OutlinedButton(
              style: AppButtonStyle.outLinedButtonStyle(onpressing: selectionwlcm.isButtonActive(ActiveButton.Buyer)),
              onPressed: (){
                selectionwlcm.setActiveButton(ActiveButton.Buyer);
              }, child: Text('Iam a Buyer',style: TextStyle(
                fontSize: AppTextStyle.heading.fontSize,
                color: selectionwlcm.isButtonActive(ActiveButton.Buyer) ? Colors.white : AppTextStyle.heading.color
              ),
              ))),
              SizedBox(height: 10),
              Obx(()=> OutlinedButton(
              style: AppButtonStyle.outLinedButtonStyle(onpressing: selectionwlcm.isButtonActive(ActiveButton.Seller)),
              onPressed: (){
                selectionwlcm.setActiveButton(ActiveButton.Seller);
                Get.to(() => Sellerview());
              }, child: Text('Iam a Seller',style: TextStyle(
                fontSize: AppTextStyle.heading.fontSize,
                color: selectionwlcm.isButtonActive(ActiveButton.Seller) ? Colors.white : AppTextStyle.heading.color)))
              ),
          ],
         ),
      )
    );
  }
}