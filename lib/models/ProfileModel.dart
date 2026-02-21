import 'package:cloud_firestore/cloud_firestore.dart';
class Profile{
  final String id;
  final String? image;
  final String dept_name;
  final String ph_no;
  final String room_no;
  final String year;

  Profile({
    required this.id,
    this.image,
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