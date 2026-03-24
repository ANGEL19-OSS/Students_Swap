import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentswap/buyer/buyer_controller.dart';
import 'package:get/get.dart';
import 'package:studentswap/buyer/chat_screen.dart';
import '../models/ProductModel.dart';
import '../models/ProfileModel.dart';
import '../models/userdatamodel.dart';

class ChatlistScreen extends StatelessWidget{
  const ChatlistScreen({super.key});

  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('InChats',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
    
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('chats').
        where('buyerId', isEqualTo: controller.user).snapshots(),         //all docss
        
       builder: (context, snapshot){
        print("Current user from controller: ${controller.user}");
             if (snapshot.connectionState == ConnectionState.waiting) {
             return Center(child: CircularProgressIndicator());
         }

  if (!snapshot.hasData || snapshot.data == null) {
    return Center(child: Text("No chats found"));
  }

  var chatDocs = snapshot.data!.docs;

  if (chatDocs.isEmpty) {
    return Center(child: Text("No chats yet"));
  }

           //list of docs
            return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (context, index){
              var chats = chatDocs[index];
              final buyerId = controller.user;
              final sellerId = chats['sellerId'];
             final Product prd = controller.allproducts.firstWhere((e) =>  chats['productId'] == e.id); //product from chatId
             final Profile prof = controller.allprofile.firstWhere((e) => prd.sellerId == e.id);//profile from product sellerId
             final Userdata user = controller.usersfrbuy.firstWhere((e) => prof.id == e.id);
             print(prof);
             ImageProvider? imageProvider;
             if(prof.image != null){
             imageProvider = FileImage(File(prof.image!));
             }
             Timestamp timestamp = chats['lastMessageTime'];
             DateTime dateTime = timestamp.toDate();
             String formattedate = DateFormat('hh:mm a').format(dateTime) ; //formattting the date from firebase
              return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: imageProvider,
        child: imageProvider == null
            ? Icon(Icons.person, color: Colors.grey.shade600)
            : null,
      ),
      title: Text(
        user.username,
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
              product: prd,
              chatId: chats.id,
              currentUserId: buyerId,
              otherUserId: sellerId,
            ));
      },
    ),
  ),
);
               
            });
       })
      );
    
  }
}