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
    return shops;
  }

  ///Вывод магазинов + лимит
  getShopsLimit(int limit) async{
    List<shop> shops = [];
    await FirebaseFirestore.instance.collection("shops").limit(limit).get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((QueryDocumentSnapshot element) {
        shops.add(shop.fromDoc(element));
      })
    });
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

  ///Вывод продуктов из магазина по id магазина + лимит
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

  ///Вывод продуктов из магазина по id магазина
  getProductsByShop(String shopId) async{
    List<products_shops> prodShops =[];
    List<product> products = [];
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
    return products;
  }

  ///Вывод информации, в каких магазинах есть продукт, указанный по id (Для вывода местоположения магазинов, вызывать getShopLocations от id полученных магазинов)
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

  ///Вывод магазина по id
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