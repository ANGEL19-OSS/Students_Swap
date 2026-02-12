import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import  'package:studentswap/selection_screen.dart';
import 'package:studentswap/welcome/welcome_screen.dart';

enum ActiveButton{
  none,
  login,
  SignIn,
  LoginUp,
  SignUp,
  Buyer,
  Seller,
  Continue,
  Addproduct,
}

class WelcomeController extends GetxController{
    final box = GetStorage();
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

     Widget getInitialScreen() {
     bool isLoggedIn = box.read('isLoggedIn') ?? false;
    return isLoggedIn ? SelectionScreen() : WelcomeScreen();
    }
}