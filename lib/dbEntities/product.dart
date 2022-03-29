import 'package:cloud_firestore/cloud_firestore.dart';

class product{
  late String _id;
  late String _name;
  late String _description;
  late String _image;
  late DocumentReference _category;
  late DocumentReference _shop;

  product.fromDoc(QueryDocumentSnapshot doc){
    _id = doc.id;
    _name = doc["name"];
    _description = doc["description"];
    _category = doc["category"];
    _shop = doc["shop"];
    _image = doc["image"];
  }

  DocumentReference get shop => _shop;

  set shop(DocumentReference value) {
    _shop = value;
  }

  DocumentReference get category => _category;

  set category(DocumentReference value) {
    _category = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }
}