import 'package:flutter/material.dart';
import 'package:studentswap/profile/profile_controller.dart';
import 'package:studentswap/utils/App_button_style.dart';
import 'package:studentswap/utils/App_text_style.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget{
  ProfileScreen({super.key});
 final WelcomeController controllerprof = Get.find<WelcomeController>();
  final ProfileController profileController =  Get.put(ProfileController());
  Widget showbox(
  String text,
  IconData iconnn,
  TextInputType type, {
  bool isPassword = false,
  String ? Function(String?)? validator, 
  void Function(String?)? onSaved,
}) {
  return Container(
    width: 350,
    height: 55,
    decoration: BoxDecoration(
      color: const Color(0xFFEAF3FC),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isPassword,
      keyboardType: type,
      validator: validator,
      onSaved: onSaved,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: InputBorder.none,

        prefixIcon: Icon(
          iconnn,
          color: const Color(0xFF4A90E2),
        ),

        hintText: text,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      backgroundColor: const Color(0xFF82BEEF),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              foregroundImage: profileController.fileimage != null ? FileImage(File(profileController.fileimage!.path)) : null
             ),
             SizedBox(height: 15,),
             Container(
                 width: 100,
                 height: 50,
                 alignment: Alignment.center,
                decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius:BorderRadius.circular(20),
                gradient: const LinearGradient(
          colors: [
             Color(0xFF82BEEF),
             Color(0xFF5FA8E5),
            ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
                ),
               child:TextButton.icon(onPressed: (){
                profileController.pickImage();
               }, label: Icon(Icons.person,color: Colors.white,size: 16,), ),
              ),
             SizedBox(height: 20,),
             Form(
              key: profileController.formkey,
               child: Column(
                children: [
                showbox('Room no: ', Icons.room, TextInputType.text, validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your room no';
                  }
                  if(value.length > 3){
                    return 'Room no Invalid';
                  }
                  return null;
                },
                onSaved: (value){
                 profileController.room_no =value!;
                }
                 ),
                SizedBox(height: 15,),
                showbox('Dept', Icons.computer,TextInputType.text, 
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your Dept';
                  }
                  if(value.length <  2){
                    return 'Dept Invalid';
                  }
                  return null;
                },
                onSaved: (value){
                 profileController.dept_name =value!;
                }
                
                ),
                SizedBox(height: 15,),
                showbox('Year', Icons.badge, TextInputType.number,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your year';
                  }
                  if(value.length < 1 || value.length > 4){
                    return 'Year Invalid';
                  }
                  return null;
                },
                onSaved: (value){
                 profileController.year =value!;
                
                }
                ),
                SizedBox(height: 15,),
                showbox('Phone number', Icons.phone,TextInputType.phone,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter phone number';
                  }
                  if(value.length > 10 || value.length < 10){
                    return 'Phone no Invalid';
                  }
                  return null;
                },
                onSaved: (value){
                 profileController.ph_no =value!;
                }),
                ],
               ),
             ),
              
              SizedBox(height: 20),
             ElevatedButton(
                style:
                  AppButtonStyle.outLinedButtonStyle(onpressing: controllerprof.isButtonActive(ActiveButton.Continue)),
                onPressed: (){
                  if(profileController.saveform()){
                 controllerprof.setActiveButton(ActiveButton.Continue);
                  }
               
                }, 
                child: Text('Continue',
                style: TextStyle(color: controllerprof.isButtonActive(ActiveButton.Continue) ?
                 Colors.white : AppTextStyle.heading.color )))
            ],
          ),
        ),
      ),
    );
  }
}

