import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentswap/seller/Addproduct.dart';
import 'package:studentswap/seller/Profile.dart';
import 'package:studentswap/seller/seller_controller.dart';
import 'package:get/get.dart';
import 'Listings.dart';

class Sellerview extends StatelessWidget{
  Sellerview({super.key});
   
   Widget build(BuildContext context){
    final SellerController sellerController = Get.put(SellerController());
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Future<String> getusername()async{
       var doc =  await FirebaseFirestore.instance.collection('users').doc(uid).get();
       return doc['name']; 
    }
    return Scaffold(
         appBar: AppBar(
         title:FutureBuilder(
          future: getusername(), 
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Text('loading..');
            }else{
              return  Text("Hi, ${snapshot.data}");
            }
          })
         ),
      body: Column(
        children: [
         Obx(()=> Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _TabButton(
                    label: "Listings",
                      selected: sellerController.selectedTab == 0,
                      onTap: ()=> sellerController.setTab(0)),
                    _TabButton(label: "Add product", 
                    selected: sellerController.selectedTab == 1, 
                    onTap: ()=> sellerController.setTab(1)),
                    _TabButton(label: "profile", 
                    selected: sellerController.selectedTab ==2,
                     onTap: ()=>sellerController.setTab(2))
                ],
              ),
            ),
          ),
          Expanded(
            child:
            Obx(() => Stack(
              children: [
                if(sellerController.selectedTab.value == 0)
                  const Listings()
                else if(sellerController.selectedTab.value == 1)
                const Addproduct()
                else 
                const Profile(),
              ],
            ),
          )
          )
        ],
      ),
         
    );
   }
  
}
class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF7CD5AD) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
