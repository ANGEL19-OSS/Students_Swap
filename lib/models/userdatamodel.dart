import  'package:cloud_firestore/cloud_firestore.dart';
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