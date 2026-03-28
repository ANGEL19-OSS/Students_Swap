import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'buyer_controller.dart';
import 'package:flutter/material.dart';
import '../models/ProductModel.dart';
import '../models/ProfileModel.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget{
  const ChatScreen({super.key,required this.profile, required this.product, required this.chatId,  required this.currentUserId,
  this.otherUserId});
  final Profile? profile;
  final Product product;
  final String chatId;
  final String? currentUserId;
final String? otherUserId;
  @override
  Widget build(BuildContext context){
    final BuyerController controller = Get.find<BuyerController>();
    ImageProvider? imageProvider;
    if(profile!.image != null){                          
     imageProvider = FileImage(File(profile!.image!));
    }
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title: Text('Messages'),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: imageProvider,
             child: imageProvider == null
                          ? const Icon(Icons.person, size: 45)
                          : null,
                )
            ],
       ),
       backgroundColor: const Color.fromARGB(255, 246, 242, 242),
       body: 
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                     ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(File(product.prod_images[0]),
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,    
                    ),
                  ),
                ),
           Expanded(
             child: StreamBuilder(stream: 
             FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').
             orderBy('timestamp').snapshots()
             , builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true, //enable reverse scrolling
                  itemCount: messages.length,
                  itemBuilder: (context, index){
                  var mes = messages[index];
                   bool isMe = mes['senderId'] == currentUserId;
             
                   return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                     child: Container(
                 padding: EdgeInsets.all(10),
                 margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                 decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  mes['text'],
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),
                   );
                });
             
             }),
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                     Expanded(
                       child: TextField(
                       controller: controller.messageController ,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Send message...',
                          border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      ),
                     contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                       ),
                     ),
                     IconButton(
               onPressed: () async {
                  if (controller.messageController.text.trim().isEmpty) return;

                    String text = controller.messageController.text.trim();
 
                         await FirebaseFirestore.instance
                   .collection('chats')
                    .doc(chatId)
                     .collection('messages')
                        .add({
                       'text': text,
                      'senderId': currentUserId,
                        'timestamp': FieldValue.serverTimestamp(),
                        });

                    await FirebaseFirestore.instance
                   .collection('chats')
                  .doc(chatId)
                  .update({
                  'lastMessage': text,
                  'lastMessageTime': FieldValue.serverTimestamp(),
                 });

                   controller.messageController.clear();
             },
               icon: Icon(Icons.send),
) ,
                ],
              ),
            )
          ],
       ),
    );
  }
}