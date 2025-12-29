import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController{

  final formkey = GlobalKey<FormState>();

  var room_no = '';
  var dept_name = '';
  var year = '';
  var ph_no ='';

  bool saveform(){
    final isvalid = formkey.currentState?.validate() ??  false;

    if(isvalid){
      return true;
    }
    formkey.currentState!.save();
    return false;
  }
}