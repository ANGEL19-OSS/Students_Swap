import 'package:flutter/material.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import '../utils/App_button_style.dart';
import '../utils/App_text_style.dart';
import 'package:get/get.dart';
import '../selection_screen.dart';
import 'Login_controller.dart';

class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final WelcomeController _welcomeloginController = Get.find<WelcomeController>();
    final LoginController _loginController = Get.put(LoginController());
    return FractionallySizedBox(
      heightFactor: 0.6,           //30% of the screen height
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _loginController.formkey,
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
                      border: InputBorder.none,
                       contentPadding: const EdgeInsets.symmetric(vertical: 16),
                       prefixIcon: Icon(Icons.person),
                       hintText: 'Name',
                     ),
                     validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your name';
                      }
                      if(value.length < 3){
                        return 'Name must be at least 3 characters Long';
                      }
                      return null;
                     },
                     onSaved: (value){
                       _loginController.username = value!;
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
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your password';
                        }
                        if(value.length < 6){
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _loginController.password = value!;
                      },
                      keyboardType: TextInputType.visiblePassword,
                     ),
                   ),
                 
                  
                 SizedBox(height: 40,),
                  Obx(
                    ()=> OutlinedButton(
                      style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomeloginController.isButtonActive(ActiveButton.LoginUp)),
                      onPressed: (){
                       if( _loginController.saveForm()){
                        _welcomeloginController.setActiveButton(ActiveButton.LoginUp);
                        Get.to(() => SelectionScreen());
                       }
                      },
                       child: Text('Login',style: TextStyle(
                        fontWeight: AppTextStyle.subheading.fontWeight,
                        color: _welcomeloginController.isButtonActive(ActiveButton.LoginUp)? Colors.white : AppTextStyle.subheading.color
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