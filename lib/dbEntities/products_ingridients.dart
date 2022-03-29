import 'package:cloud_firestore/cloud_firestore.dart';

class products_ingridients {
  late DocumentReference _ingridient_id;
  late DocumentReference _product_id;

  products_ingridients.fromDoc(QueryDocumentSnapshot doc){
    _ingridient_id = doc["ingridient_id"];
    _product_id = doc["product_id"];
  }

  DocumentReference get product_id => _product_id;

  set product_id(DocumentReference value) {
    _product_id = value;
  }

  DocumentReference get ingridient_id => _ingridient_id;

  set ingridient_id(DocumentReference value) {
    _ingridient_id = value;
  }
}