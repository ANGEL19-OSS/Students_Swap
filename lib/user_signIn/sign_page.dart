import 'dart:math';

import 'package:flutter/material.dart';
import 'package:studentswap/profile/Profile_screen.dart';
import 'package:studentswap/user_signIn/Sign_controller.dart';
import 'package:studentswap/utils/App_button_style.dart';
import 'package:studentswap/utils/App_text_style.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import 'package:get/get.dart';

class SignPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   final WelcomeController _welcomesignController = Get.find<WelcomeController>();
   final SignController _signcontroller = Get.put(SignController());
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _signcontroller.formKey,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                         contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                      prefixIcon: Icon(Icons.badge),
                      hintText: 'Student Id',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter you Student Id';
                      }
                      if(value.length < 12){
                        return 'Enter your registered Student No';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _signcontroller.studentId = value!;
                    },
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                     decoration: InputDecoration(
                       contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                       prefixIcon: Icon(Icons.person),
                       hintText: 'Name',
                     ),
                     validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter you name';
                      }
                      if(value.length < 3){
                        return 'Enter valid name';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _signcontroller.name = value!;
                    },
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                       contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your email';
                      }
                      if(!value.contains('@')){
                        return 'Enter valid email';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _signcontroller.email = value!;
                    },
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                      validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your password';
                      }
                      if(value.length < 6){
                        return 'Enter valid password';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _signcontroller.password = value!;
                    },
                      keyboardType: TextInputType.visiblePassword,
                     ),
                   ),
                 
                  
                 SizedBox(height: 40,),
                  Obx(
                    ()=> OutlinedButton(
                      style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomesignController.isButtonActive(ActiveButton.SignUp)),
                      onPressed: (){
                        if(_signcontroller.SaveSignForm()){
                        _welcomesignController.setActiveButton(ActiveButton.SignUp);
                        Get.to(() => ProfileScreen());
                        }
                      },
                       child: Text('Sign Up',style: TextStyle(
                        fontWeight: AppTextStyle.subheading.fontWeight,
                        color: _welcomesignController.isButtonActive(ActiveButton.SignUp) ? Colors.white : AppTextStyle.subheading.color
                       ))),
                  ) 
              ],
            ),
          ),
        ),
      ),
    );
  }
}