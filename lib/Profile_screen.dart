import 'package:flutter/material.dart';
import 'package:studentswap/utils/App_button_style.dart';
import 'package:studentswap/utils/App_text_style.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

   showbox(String text, IconData iconnn, TextInputType type ){
      return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 189, 216, 238),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(9)),
       child:  TextFormField(
        decoration: InputDecoration(
         border: InputBorder.none,
         prefixIcon: Icon(iconnn),
         hintText: text
         ),
      keyboardType: type,
       )
      );
  }

  @override
  Widget build(BuildContext context){
   final  WelcomeController controller1 = Get.find<WelcomeController>();
    return Scaffold(
      backgroundColor: const Color(0xFF82BEEF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Material(
            elevation: 8,
         //   shadowColor: const Color(0xFF82BEEF),
             child: Container(
                 width: 80,
                 height: 50,
                decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius:BorderRadius.circular(20)
                ),
               child: Text('Create Profile',
                 )
              ,),
           ),
           SizedBox(height: 20,),
           Material(
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 92, 95, 95),
             child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(''),
             ),
           ),
           SizedBox(height: 15),
            showbox('Room no: ', Icons.room, TextInputType.text),
            SizedBox(height: 15,),
            showbox('Dept', Icons.computer,TextInputType.text),
            SizedBox(height: 15,),
            showbox('Year', Icons.badge, TextInputType.number),
            SizedBox(height: 15,),
            showbox('Phone number', Icons.phone,TextInputType.phone),
            SizedBox(height: 20),
            ElevatedButton(
              style:
                AppButtonStyle.outLinedButtonStyle(onpressing: controller1.isButtonActive(ActiveButton.Continue)),
              onPressed: (){
               controller1.setActiveButton(ActiveButton.Continue);
              }, 
              child: Text('Continue',
              style: TextStyle(color: controller1.isButtonActive(ActiveButton.Continue) ?
               Colors.white : AppTextStyle.heading.color )))
          ],
        ),
      ),
    );
  }
}

