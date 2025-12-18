import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
     var isHovering = false.obs;
     var isHoveringLogin = false.obs;
     var isHoveringSignUp = false.obs;
     var isHoveringSignIn =  false.obs;
      Rx<Color> bg_color = Colors.white.obs;
      void onInit(){
       bg_color.value = Colors.white;
       super.onInit();
      }

     void onHover(){          //setter 
      isHovering.value = !isHovering.value;      //like toggle when pressed again it will be false
      isHoveringLogin.value = false;
      bg_color.value = const Color(0xFF82BEEF);
     }
     void onHoverLogin(){
      isHoveringLogin.value = !isHoveringLogin.value;
      isHovering.value = false;
      bg_color.value = const Color(0xFF82BEEF);
     }
     void onHoverSignUp(){
      isHoveringSignUp.value = !isHoveringSignUp.value;
    
     }
     void onHoverSignIn(){
     isHoveringSignIn.value = !isHoveringSignIn.value;
     }
}