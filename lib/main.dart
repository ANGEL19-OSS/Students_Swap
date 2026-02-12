import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:studentswap/buyer/buyer_controller.dart';
import 'package:studentswap/profile/Profile_screen.dart';
import 'package:studentswap/seller/Addproduct.dart';
import 'package:studentswap/seller/seller_controller.dart';
import 'package:studentswap/seller/sellerview.dart';
import 'package:studentswap/welcome/welcome_controller.dart';
import 'package:studentswap/user_login/Login_controller.dart';
import 'welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(  
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();          //initializing
  Get.put(WelcomeController());
  Get.put(LoginController(), permanent: true);
  Get.put(SellerController(), permanent: true);
  Get.put(BuyerController(),permanent: true);
  runApp(
     MyApp());
}


class MyApp extends StatelessWidget{
 MyApp({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context){
    final WelcomeController controller = Get.find<WelcomeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:controller.getInitialScreen(),
    );
  }
}