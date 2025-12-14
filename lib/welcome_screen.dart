import 'package:flutter/material.dart';
import 'package:studentswap/utils/App_text_style.dart';
class WelcomeScreen extends StatefulWidget{
   const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
   bool isHovering = false;
   bool isHoveringLogin = false;
   @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
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
              OutlinedButton(
                 style: OutlinedButton.styleFrom(
                    backgroundColor: isHovering ? AppTextStyle.heading.color : Colors.white,
                    minimumSize: Size(350, 50),
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(9))
                    ),
                 ),
                 onPressed: (){
                    setState(() {
                      isHovering = !isHovering;
                      
                    });
                 }, child: 
                 Text('Sign Up', textAlign: TextAlign.center,
                 style: TextStyle(fontWeight: AppTextStyle.subheading.fontWeight,
                 color: isHovering ? Colors.white : AppTextStyle.subheading.color)
                 )),
                 SizedBox(height: 10,),
                 OutlinedButton(
                      style: OutlinedButton.styleFrom(
                       backgroundColor: isHoveringLogin ? AppTextStyle.heading.color : Colors.white,
                    minimumSize: Size(350, 50),
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(9))
                    ),
                 ),
                  onPressed: (){
                    setState(() {
                       isHoveringLogin = !isHoveringLogin;
                    });
                  }, 
                  child: Text('Log In', textAlign: TextAlign.center,style: TextStyle(fontWeight: AppTextStyle.subheading.fontWeight
                  ,color: isHoveringLogin ? Colors.white : AppTextStyle.subheading.color)))
        ],),
      )
     );
  }
}