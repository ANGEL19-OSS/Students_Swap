import 'package:flutter/material.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import '../utils/App_button_style.dart';
import '../utils/App_text_style.dart';
import 'package:get/get.dart';
import '../selection_screen.dart';

class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final WelcomeController _welcomeloginController = Get.find<WelcomeController>();
    return FractionallySizedBox(
      heightFactor: 0.6,           //30% of the screen height
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
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
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                   ),
                 ),
               
                
               SizedBox(height: 40,),
                Obx(
                  ()=> OutlinedButton(
                    style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomeloginController.isHoveringSignIn.value),
                    onPressed: (){
                      _welcomeloginController.onHoverSignIn();
                      Get.to(() => SelectionScreen());
                    },
                     child: Text('Login',style: TextStyle(
                      fontWeight: AppTextStyle.subheading.fontWeight,
                      color: _welcomeloginController.isHoveringSignIn.value ? Colors.white : AppTextStyle.subheading.color
                     ))),
                )
            ],
          ),
        ),
      ),
    );
  }
}