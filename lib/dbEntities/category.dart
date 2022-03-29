import 'package:cloud_firestore/cloud_firestore.dart';

class category{
  late String _id;
  late String _name;

  category.fromDoc(QueryDocumentSnapshot doc){
    _id = doc.id;
    _name = doc["name"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}