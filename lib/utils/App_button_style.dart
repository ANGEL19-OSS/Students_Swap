import 'package:flutter/material.dart';
import 'package:studentswap/utils/App_text_style.dart';

class AppButtonStyle {
  static ButtonStyle outLinedButtonStyle({required  bool onpressing}){
    return OutlinedButton.styleFrom(
      backgroundColor: onpressing? AppTextStyle.heading.color : Colors.white,
      minimumSize: Size(350, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
     side: BorderSide(
      color: const Color(0xFF0000FF),
      width: 2,
      style: BorderStyle.solid
     )
    );
  }
}