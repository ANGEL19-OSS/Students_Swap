import 'package:flutter/material.dart';
import 'package:studentswap/buyer/buyer_controller.dart';
import 'package:studentswap/buyer/buyerview.dart';
import 'package:studentswap/buyer/cart_screen.dart';
import 'package:studentswap/seller/Profile.dart';
import 'package:get/get.dart';

class Bottomnavbuyer extends StatelessWidget{
  const Bottomnavbuyer({super.key});

  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
    final pages =[
    Buyerview(),
    CartScreen(),
    Profile(),
    ];
    return Scaffold(
     bottomNavigationBar: Obx(() {
    return Container(
    margin: const EdgeInsets.all(14),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(Icons.home_rounded, 0),
        _navItem(Icons.shopping_cart_rounded, 1),
        _navItem(Icons.person_rounded, 2),
        _navItem(Icons.chat_rounded, 3),
      ],
    ),
  );
}),
       body: Obx(()=>
          IndexedStack(
          index:controller.selectedpage.value ,
          children: pages,
         ),
       ),     
    );
  }
}
Widget _navItem(IconData icon, int index) {
  String _label(int index) {
  switch (index) {
    case 0:
      return "Home";
    case 1:
      return "Cart";
    case 2:
      return "Char";
    case 3:
    return "Profile";
    default:
      return "";
  }
}
  final controller = Get.find<BuyerController>();
  final isSelected = controller.selectedpage.value == index;

  return GestureDetector(
    onTap: () => controller.changepage(index),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 18 : 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4CB6E6) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          if (isSelected) ...[
            const SizedBox(width: 6),
            Text(
              _label(index),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ]
        ],
      ),
    ),
  );
}