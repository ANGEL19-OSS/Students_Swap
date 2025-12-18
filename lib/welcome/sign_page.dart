import 'dart:math';

import 'package:flutter/material.dart';
import 'package:studentswap/utils/App_button_style.dart';
import 'package:studentswap/utils/App_text_style.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import 'package:get/get.dart';

class SignPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   final WelcomeController _welcomesignController = Get.find<WelcomeController>();
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               Container(
                 width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                   color: const Color(0xFF82BEEF),
                   shape:  BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(9)),
                 child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.badge),
                    labelText: 'Student Id',
                  ),
                  keyboardType: TextInputType.number,
                 ),
               ),
               SizedBox(height: 20),
                Container(
                   width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                   color: const Color(0xFF82BEEF),
                   shape:  BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(9)),
                  child: TextFormField(
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.person),
                     labelText: 'Name',
                   ),
                   keyboardType: TextInputType.name,
                  ),
                ),
               SizedBox(height: 20),
               Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                   color: const Color(0xFF82BEEF),
                   shape:  BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(9)),
                 child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                 ),
               ),
               SizedBox(height: 20),
                 Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                   color: const Color(0xFF82BEEF),
                   shape:  BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(9)),
                   child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                   ),
                 ),
               
                
               SizedBox(height: 40,),
                Obx(
                  ()=> OutlinedButton(
                    style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomesignController.isHoveringSignUp.value),
                    onPressed: (){
                      _welcomesignController.onHoverSignUp();
                    },
                     child: Text('Sign Up',style: TextStyle(
                      fontWeight: AppTextStyle.subheading.fontWeight,
                      color: _welcomesignController.isHoveringSignUp.value ? Colors.white : AppTextStyle.subheading.color
                     ))),
                )
            ],
          ),
        ),
      ),
    );
  }
}