import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_web/dbEntities/shop_location.dart';

class shop {
  late String _id;
  late String _name;
  late String _phone_number;
  late String _vk;
  late String _website;
  late String _image;
  List<shop_location>? _locations;

  shop.fromDoc(QueryDocumentSnapshot doc){
    _id = doc.id;
    _name = doc["name"];
    _phone_number = doc["phone_number"];
    _vk = doc["vk"];
    _website = doc["website"];
    _image = doc["image"];
  }

  shop(DocumentSnapshot<Map<String, dynamic>> value){
    _id=value.id;
    _name=value.get("name");
    _phone_number = value.get("phone_number");
    _vk = value.get("vk");
    _website = value.get("website");
    _image = value.get("image");
  }


  String get website => _website;

  set website(String value) {
    _website = value;
  }

  String get vk => _vk;

  set vk(String value) {
    _vk = value;
  }

  String get phone_number => _phone_number;

  set phone_number(String value) {
    _phone_number = value;
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

  List<shop_location>? get locations => _locations;

  set locations(List<shop_location>? value) {
    _locations = value;
  }
}