import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String productname;
  final String price;
  final String condition;
  final String sellerNumber;
  final List prod_images;

  Product({
    required this.id,
    required this.productname,
    required this.price,
    required this.condition,
    required this.sellerNumber,
    required this.prod_images,
  });
  factory Product.fromDoc(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      productname: doc['productname'],
      price: doc['price'],
      condition: doc['condition'],
      sellerNumber: doc['sellerNumber'],
      prod_images: List.from(doc['prod_images']),
    );
  }
}

class Profile{
  final String id;
  final String image;
  final String dept_name;
  final String ph_no;
  final String room_no;
  final String year;

  Profile({
    required this.id,
    required this.image,
    required this .dept_name,
    required this.ph_no,
    required this.room_no,
    required this.year,
  });
  factory Profile.fromDoc(DocumentSnapshot doc){
    return Profile(
      id: doc.id, 
      image: doc['image'],
      dept_name: doc['dept_name'],
      ph_no: doc['ph_no'],
      room_no: doc['room_no'], 
      year: doc['year']);
  }
}

class Userdata{
  final String id;
  final String username;
  final String studentId;

  Userdata({
    required this.id,
    required this.username,
    required this.studentId,
  });
  factory Userdata.fromDoc(DocumentSnapshot doc){
    return Userdata(
        id: doc.id,
       username: doc['name'],
        studentId: doc['studentId']) ;
  }
}