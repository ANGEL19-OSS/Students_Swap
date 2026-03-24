import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studentswap/buyer/buyer_controller.dart';
import 'package:studentswap/seller/seller_controller.dart';
import '../models/ProductModel.dart';
import '../models/ProfileModel.dart';
import '../models/userdatamodel.dart';
import 'package:intl/intl.dart';
import '../buyer/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chatlistscreen extends StatelessWidget{
  const Chatlistscreen({super.key});

  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
    print("Seller screen UID: ${FirebaseAuth.instance.currentUser!.uid}");

       return Scaffold(
             appBar: AppBar(
               title: Text('InChats',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              leading: IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
             ),
             backgroundColor: Colors.white,
             body: 
             StreamBuilder( 
              stream:
               FirebaseFirestore.instance.collection('chats').
             where('sellerId' , isEqualTo: FirebaseAuth.instance.currentUser!.uid ).snapshots(), //docs containing the sellerId
              builder: (context, snapshot){            
                 if(snapshot.connectionState == ConnectionState.waiting ){
                     return Center(child: CircularProgressIndicator());
                 }
                 if(!snapshot.hasData){
                    return Center(child: Text("No chats found"));
                 }
                 var docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index){
                   var chats = docs[index];
                   String sellerId = controller.user;
                   String buyerId = chats['buyerId'];
                   final Product prod = controller.allproducts.firstWhere((e) => chats['productId'] == e.id);
                   final Profile prof = controller.allprofile.firstWhere((e) => e.id == buyerId);
                  final Userdata userr = controller.usersfrbuy.firstWhere((e) => e.id == buyerId);
                   ImageProvider? imageProvider;  
                   if(prof.image !=  null){
                    imageProvider  = FileImage(File(prof.image!));
                   }  
                     Timestamp timestamp = chats['lastMessageTime'];
                      DateTime dateTime = timestamp.toDate();
                     String formattedate = DateFormat('hh:mm:a').toString();      
                   return Container(
                      color: Colors.white,
                       child:  ListTile(
                             leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: imageProvider,
                              child: imageProvider == null ?Icon(Icons.person, color: Colors.black,) : null,
                             ),
                             title: Text(
                        userr.username,
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 16,
                                ),
                          ),
                          subtitle: Padding(
                         padding: const EdgeInsets.only(top: 4),
                           child: Text(
                              chats['lastMessage'] ?? '',
                                 maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      ),
                      ),
                    ),
                 trailing:  Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                     formattedate, // format timestamp here
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                    SizedBox(height: 4),
                     Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                       ],
                  ),
                   onTap: () {
                 Get.to(() => ChatScreen(

                     profile: prof,
                      product: prod,
                    chatId: chats.id,
                    currentUserId: sellerId,
                    otherUserId: buyerId,
            ));
                       },
                       ),

                     );
                });

              }) ,
       );
  }
}