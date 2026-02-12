import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String productname;
  final String price;
  final String condition;
  final String sellerNumber;
  final List prod_images;
  final String sellerId;
 

  Product({
    required this.id,
    required this.productname,
    required this.price,
    required this.condition,
    required this.sellerNumber,
    required this.prod_images,
    required this.sellerId,
    
  });
  factory Product.fromDoc(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      productname: doc['productname'],
      price: doc['price'],
      condition: doc['condition'],
      sellerNumber: doc['sellerNumber'],
      prod_images: List.from(doc['prod_images']),
      sellerId: doc['sellerId']
    );
  }
}
