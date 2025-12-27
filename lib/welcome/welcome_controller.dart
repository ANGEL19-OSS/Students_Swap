import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ActiveButton{
  none,
  login,
  SignIn,
  LoginUp,
  SignUp,
  Buyer,
  Seller,
  Continue,
}

class WelcomeController extends GetxController{
      Rx<ActiveButton> activeButton = ActiveButton.none.obs;
    
      Rx<Color> bg_color = Colors.white.obs;    // var bg_color = Colors.white.obs does the same
      void onInit(){
       bg_color.value = Colors.white;
       super.onInit();
      }

      void setActiveButton(ActiveButton button){ //setter
        activeButton.value = activeButton.value ==  button ? ActiveButton.none : button;

        bg_color.value = activeButton.value == ActiveButton.none ? Colors.white : const Color(0xFF82BEEF);
      }

     bool isButtonActive(ActiveButton button){          //checker 
      return activeButton.value == button;
     }
}