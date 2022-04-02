import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:tea_web/dbEntities/product.dart';
import 'package:tea_web/dbEntities/products_ingridients.dart';
import 'package:tea_web/dbEntities/products_shops.dart';
import 'package:tea_web/dbEntities/shop.dart';
import 'package:tea_web/dbEntities/shop_location.dart';

import 'category.dart';
import 'ingidient.dart';

class dbFunctions{

  ///Вывод всех магазинов
  getShops() async{
    List<shop> shops = [];
    await FirebaseFirestore.instance.collection("shops").get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((QueryDocumentSnapshot element) {
        shops.add(shop.fromDoc(element));
      })
    });
    for (int i=0;i<shops.length;i++){
      List<shop_location> shopLocations = [];
      final tempRef = FirebaseFirestore.instance.collection("shops").doc(shops[i].id);
      await FirebaseFirestore.instance.collection("shop_locations").where("shop",isEqualTo: tempRef).get().then((value) => {
        value.docs.forEach((element) {
          shopLocations.add(shop_location.fromDoc(element));
        })
      });
      shops[i].locations = shopLocations;
    }
    return shops;
  }

  /// функция для вывода магазинов с ограничением до limit магазинов
  getShopsLimit(int limit) async{
    List<shop> shops = [];
    await FirebaseFirestore.instance.collection("shops").limit(limit).get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((QueryDocumentSnapshot element) {
        shops.add(shop.fromDoc(element));
      })
    });
    for (int i=0;i<shops.length;i++){
      List<shop_location> shopLocations = [];
      final tempRef = FirebaseFirestore.instance.collection("shops").doc(shops[i].id);
      await FirebaseFirestore.instance.collection("shop_locations").where("shop",isEqualTo: tempRef).get().then((value) => {
        value.docs.forEach((element) {
          shopLocations.add(shop_location.fromDoc(element));
        })
      });
      shops[i].locations = shopLocations;
    }
    return shops;
  }

  ///Вывод локаций по id магазина
  getShopLocations(String id) async{
    List<shop_location> shopLocations = [];
    final ref = FirebaseFirestore.instance.collection("shops").doc(id);
    await FirebaseFirestore.instance.collection("shop_locations").where("shop",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        shopLocations.add(shop_location.fromDoc(element));
      })
    });
    return shopLocations;
  }

  ///Вывод всех категорий
  getCategory() async{
    List<category> categories = [];
    await FirebaseFirestore.instance.collection("categories").get().then((value) => {
      value.docs.forEach((element) {
        categories.add(category.fromDoc(element));
      })
    });
    return categories;
  }

  ///Вывод всех ингредиентов
  getIngridient() async{
    List<ingridient> ingridients = [];
    await FirebaseFirestore.instance.collection("ingridients").get().then((value) => {
      value.docs.forEach((element) {
        ingridients.add(ingridient.fromDoc(element));
      })
    });
    return ingridients;
  }

  ///Вывод всех продуктов
  getProducts() async{
    List<product> products = [];
    await FirebaseFirestore.instance.collection("products").get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
    return products;
  }

  ///функция выводит товары из этого магазина с ограничением до limit
  getProductsLimit(String shopId, int limit) async{
    List<products_shops> prodShops =[];
    List<product> products = [];
    final ref = FirebaseFirestore.instance.collection("shops").doc(shopId);
    await FirebaseFirestore.instance.collection("products_shops").where("shop_id",isEqualTo: ref).limit(limit).get().then((value) => {
      value.docs.forEach((element) {
        prodShops.add(products_shops.fromDoc(element));
      })
    });
    for(int i=0; i<prodShops.length;i++) {
      await FirebaseFirestore.instance.collection("products").doc(
          prodShops[i].product_id.id).get().then((value) =>
      {
        products.add(product(value)),
      });
    }
    return products;
  }

  ///функция на вход получает id магазина и выводит информацию о всех продуктах для этого магазина и все связи записи связанные с этими продуктами из таблицы product-ingridient
  getProductsByShop(String shopId) async{
    List<products_shops> prodShops =[];
    List<product> products = [];
    List<products_ingridients> prodIngr =[];
    var list = [];
    final ref = FirebaseFirestore.instance.collection("shops").doc(shopId);
    await FirebaseFirestore.instance.collection("products_shops").where("shop_id",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        prodShops.add(products_shops.fromDoc(element));
      })
    });
    for(int i=0; i<prodShops.length;i++) {
      await FirebaseFirestore.instance.collection("products").doc(
          prodShops[i].product_id.id).get().then((value) =>
      {
        products.add(product(value)),
      });
    }
    List<DocumentReference> drs = [];
    for (int i=0; i<products.length;i++){
      drs.add(FirebaseFirestore.instance.collection("products").doc(products[i].id));
    }
    var listDrs = drs;
    await FirebaseFirestore.instance.collection("products_ingridients").where("product_id",whereIn: listDrs).get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    for (int i=0; i<products.length;i++){
      products[i].prodIngredients = prodIngr;
    }
    Map<String,dynamic> newmap = {
      "products" : products,
      "products_ingridients" : prodIngr,
    };
    List<product> test = newmap["products"];
    List<products_ingridients> test2 = newmap["products_ingridients"];
    test.forEach((element) {
      print(element.name);
    });
    test2.forEach((element) {
      print(element.ingridient_id);
    });
    return products;
  }

  ///функция на вход получает id продукта и выводит магазины, в которых есть этот продукт с их адресами
  getShopInfoByProduct(String productId) async{
    List<products_shops> prodShops =[];
    List<shop> shops = [];
    final ref = FirebaseFirestore.instance.collection("products").doc(productId);
    await FirebaseFirestore.instance.collection("products_shops").where("product_id",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        prodShops.add(products_shops.fromDoc(element));
      })
    });
    for(int i=0;i<prodShops.length;i++){
      await FirebaseFirestore.instance.collection("shops").doc(prodShops[i].shop_id.id).get().then((value) => {
        shops.add(shop(value))
      });
    }
    for (int i=0;i<shops.length;i++){
      List<shop_location> shopLocations = [];
      final tempRef = FirebaseFirestore.instance.collection("shops").doc(shops[i].id);
      await FirebaseFirestore.instance.collection("shop_locations").where("shop",isEqualTo: tempRef).get().then((value) => {
        value.docs.forEach((element) {
          shopLocations.add(shop_location.fromDoc(element));
        })
      });
      shops[i].locations = shopLocations;
    }
    shops.forEach((element) {
      element.locations?.forEach((el) {
        print(el.location);
      });
    });
    return shops;
  }


  ///Вывод смежной таблицы (я думаю бесполезен)
  getProductsIngridients() async{
    List<products_ingridients> prodIngr = [];
    await FirebaseFirestore.instance.collection("products_ingridients").get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    return prodIngr;
  }

  ///Вывод магазина по id магазина
  getShopById(String id) async{
    late shop newShop;
    await FirebaseFirestore.instance.collection("shops").doc(id).get().then((value) => {
      newShop = shop(value)
    });
    return newShop;
  }

  ///Вывод списка ингредиентов в продукте
  getIngredientsByProduct(String id) async{
    List<products_ingridients> prodIngr =[];
    List<ingridient> ingredients = [];
    final ref = FirebaseFirestore.instance.collection("products").doc(id);
    await FirebaseFirestore.instance.collection("products_ingridients").where("product_id",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    for(int i=0;i<prodIngr.length;i++){
       await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
        ingredients.add(ingridient(value))
      });
    }
    return ingredients;
  }

  ///Вывод продуктов по категории
  getProductsByCategory(String categoryId) async{
    List<product> products = [];
    final ref = FirebaseFirestore.instance.collection("categories").doc(categoryId);
    await FirebaseFirestore.instance.collection("products").where("category",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
    return products;
  }

  ///Вывод продуктов из той же категории, что и указанный продукт
  getAllProductsInCategory(DocumentReference category) async{
    List<product> products = [];
    await FirebaseFirestore.instance.collection("products").where("category",isEqualTo: category).get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
    return products;
  }


}