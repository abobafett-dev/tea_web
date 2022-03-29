import 'package:cloud_firestore/cloud_firestore.dart';

class shop_location{
  late String _id;
  late String _location;
  late DocumentReference _shop;

  shop_location.fromDoc(QueryDocumentSnapshot doc){
    _id = doc.id;
    _location = doc["location"];
    _shop = doc["shop"];
  }

  DocumentReference get shop => _shop;

  set shop(DocumentReference value) {
    _shop = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}