import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  final String product_name;
  final String price;
  final String seller_num;
  final String image;
  final String seller_id;
 

  CartModel({
    required this.id,
    required this.product_name,
    required this.price,
    required this.seller_num,
    required this.image,
    required this.seller_id,
    
  });
  factory CartModel.fromDoc(DocumentSnapshot doc) {
    return CartModel(
      id: doc.id,
      product_name: doc['product_name'],
      price: doc['product_price'],
      seller_num: doc['seller_number'],
      image: doc['product_image'],
      seller_id: doc['seller_id']
    );
  }
}
