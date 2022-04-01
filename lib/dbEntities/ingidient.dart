import 'package:cloud_firestore/cloud_firestore.dart';

class ingridient{
  late String _id;
  late String _name;

  ingridient.fromDoc(QueryDocumentSnapshot doc){
    _id = doc.id;
    _name = doc["name"];
  }

  ingridient(DocumentSnapshot<Map<String, dynamic>> value){
    _id=value.id;
    _name=value.get("name");
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