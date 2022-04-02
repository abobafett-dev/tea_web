import 'package:cloud_firestore/cloud_firestore.dart';

class products_shops{
  late String _id;
  late DocumentReference _shop_id;
  late DocumentReference _product_id;

  products_shops.fromDoc(QueryDocumentSnapshot doc){
    _shop_id = doc["shop_id"];
    _product_id = doc["product_id"];
  }

  DocumentReference get product_id => _product_id;

  set product_id(DocumentReference value) {
    _product_id = value;
  }

  DocumentReference get shop_id => _shop_id;

  set shop_id(DocumentReference value) {
    _shop_id = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}