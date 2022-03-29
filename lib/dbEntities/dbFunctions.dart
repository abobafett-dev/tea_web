import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tea_web/dbEntities/product.dart';
import 'package:tea_web/dbEntities/products_ingridients.dart';
import 'package:tea_web/dbEntities/shop.dart';
import 'package:tea_web/dbEntities/shop_location.dart';

import 'category.dart';
import 'ingidient.dart';

class dbFunctions{
  getShops() async{
    List<shop> shops = [];
    await FirebaseFirestore.instance.collection("shops").get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((QueryDocumentSnapshot element) {
        shops.add(shop.fromDoc(element));
      })
    });
    return shops;
  }

  getShopLocations() async{
    List<shop_location> shopLocations = [];
    await FirebaseFirestore.instance.collection("shop_locations").get().then((value) => {
      value.docs.forEach((element) {
        shopLocations.add(shop_location.fromDoc(element));
      })
    });
    return shopLocations;
  }

  getCategory() async{
    List<category> categories = [];
    await FirebaseFirestore.instance.collection("categories").get().then((value) => {
      value.docs.forEach((element) {
        categories.add(category.fromDoc(element));
      })
    });
    return categories;
  }

  getIngridient() async{
    List<ingridient> ingridients = [];
    await FirebaseFirestore.instance.collection("ingridients").get().then((value) => {
      value.docs.forEach((element) {
        ingridients.add(ingridient.fromDoc(element));
      })
    });
    return ingridients;
  }

  getProducts() async{
    List<product> products = [];
    await FirebaseFirestore.instance.collection("products").get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
    return products;
  }

  getProductsIngridients() async{
    List<products_ingridients> prodIngr = [];
    await FirebaseFirestore.instance.collection("products_ingridients").get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    return prodIngr;
  }

  getShopById(String id) async{
    late shop newShop;
    await FirebaseFirestore.instance.collection("shops").doc(id).get().then((value) => {
      newShop = shop(value)
    });
    return newShop;
  }
}