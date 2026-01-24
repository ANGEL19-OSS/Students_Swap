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
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _loginController.formkey,
              child: Column(
                children: [
                    TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF82BEEF),
                     border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'StudentId',
                    ),
                    validator: (value){
                     if(value == null || value.isEmpty){
                       return 'Please enter your studentId';
                     }
                      if(value.length < 12){
                        return 'Enter a valid studentId';
                      }
                     return null;
                    },
                    onSaved: (value){
                      _loginController.userId = value!;
                    },
                    keyboardType: TextInputType.number,
                                          
                                          ),
                  
                   SizedBox(height: 20),
                     TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF82BEEF),
                        filled: true,
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
                   
                    
                   SizedBox(height: 40,),
                    Obx(
                      ()=> OutlinedButton(
                        style: AppButtonStyle.outLinedButtonStyle(onpressing: _welcomeloginController.isButtonActive(ActiveButton.LoginUp)),
                        onPressed: ()async{
                         if( await _loginController.loginUser()){
                          _welcomeloginController.setActiveButton(ActiveButton.LoginUp);
                          print('yepp');
                          Get.back();
                          Get.off(() => SelectionScreen());
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
      ),
    );
  }
}