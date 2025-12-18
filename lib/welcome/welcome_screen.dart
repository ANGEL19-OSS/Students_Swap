import 'package:flutter/material.dart';
import 'package:studentswap/utils/App_text_style.dart';
import 'package:studentswap/welcome/sign_page.dart';
import '../welcome/Login_page.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import '../../utils/App_button_style.dart';
import 'package:get/get.dart';
class WelcomeScreen extends StatelessWidget{
    WelcomeScreen({super.key, this.onpressing});
   final Function()? onpressing;
   final WelcomeController _welcomeController = Get.put(WelcomeController());

   @override
  Widget build(BuildContext context) {
     return Obx(
       ()=> Scaffold(
        backgroundColor: _welcomeController.bg_color.value ,
        body:Center(
          child: Column(children: [
              Image.asset('assets/assets/Welcome_bg.png',
              fit: BoxFit.fill,
              height: 400,
              ),
              SizedBox(height: 40,),
              Text('Welcome to StudentSwap',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold ),
              ),
              SizedBox(height: 5,),
              Text('Buy and Sell anything easily',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
              Text('Start exploring now',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
              SizedBox(height: 50,),
                Obx(
                  ()=> OutlinedButton(
                  style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomeController.isHovering.value),
                     onPressed: (){
                        _welcomeController.onHover();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          
                          ),
                          context: context, builder:(context) => SignPage() );
                    
                     }, child: 
                     Text('Sign Up', textAlign: TextAlign.center,
                     style: TextStyle(fontWeight: AppTextStyle.subheading.fontWeight,
                     color: _welcomeController.isHovering.value ? Colors.white : AppTextStyle.subheading.color)
                     )),
                ),
                   SizedBox(height: 10,),
                   Obx(
                     () => OutlinedButton(
                          style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomeController.isHoveringLogin.value),
                      onPressed: (){
                          _welcomeController.onHoverLogin();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            ),
                            context: context,
                             builder: (context) => LoginPage());
                      }, 
                      child: Text('Log In', textAlign: TextAlign.center,style: TextStyle(fontWeight: AppTextStyle.subheading.fontWeight
                      ,color: _welcomeController.isHoveringLogin.value ? Colors.white : AppTextStyle.subheading.color))),
                   )
          ],),
        )
       ),
     );
  }
}