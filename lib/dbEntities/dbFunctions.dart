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
    List<products_ingridients> prodIngr = [];
    await FirebaseFirestore.instance.collection("products").get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
    await FirebaseFirestore.instance.collection("products_ingridients").get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    for(int j=0;j<products.length;j++){
      List<ingridient> ingrs = [];
      for (int i=0;i<prodIngr.length;i++){
        if (prodIngr[i].product_id.toString().contains(products[j].id)){
          await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
            ingrs.add(ingridient(value))
          });
        }
      }
      products[j].ingredients=ingrs;
    }
    return products;
  }

  ///функция выводит товары из этого магазина с ограничением до limit
  getProductsLimit(String shopId, int limit) async{
    List<products_shops> prodShops =[];
    List<product> products = [];
    List<products_ingridients> prodIngr = [];
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
    await FirebaseFirestore.instance.collection("products_ingridients").get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    for(int j=0;j<products.length;j++){
      List<ingridient> ingrs = [];
      for (int i=0;i<prodIngr.length;i++){
        if (prodIngr[i].product_id.toString().contains(products[j].id)){
          await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
            ingrs.add(ingridient(value))
          });
        }
      }
      products[j].ingredients=ingrs;
    }
    return products;
  }

  ///функция на вход получает id магазина и выводит информацию о всех продуктах для этого магазина и все связи записи связанные с этими продуктами из таблицы product-ingridient
  ///Возращает карту где mapName["products"] - лист продуктов, а mapName["products_ingridients"] - лист из соответствующей таблицы.
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
    for(int j=0;j<products.length;j++){
      List<ingridient> ingrs = [];
      for (int i=0;i<prodIngr.length;i++){
        if (prodIngr[i].product_id.toString().contains(products[j].id)){
          await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
            ingrs.add(ingridient(value))
          });
        }
      }
      products[j].ingredients=ingrs;
    }
    Map<String,dynamic> newmap = {
      "products" : products,
      "products_ingridients" : prodIngr,
    };
    return newmap;
  }

  ///функция на вход получает id продукта и выводит информацию по этому продукту, так же выводит магазины, в которых есть этот продукт с их адресами
  ///Возвращает map, где mapName["product"] - содержит инофрмацию по продукту,  mapName["shops"] - содержит магазины и их адреса
  getShopInfoByProduct(String productId) async{
    List<products_shops> prodShops =[];
    List<products_ingridients> prodIngr =[];
    List<shop> shops = [];
    late product _product;
    await FirebaseFirestore.instance.collection("products").doc(productId).get().then((value) => {
      _product = product(value)
    });
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
    await FirebaseFirestore.instance.collection("products_ingridients").where("product_id",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    List<ingridient> ingrs = [];
    for (int i=0;i<prodIngr.length;i++){
      await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
        ingrs.add(ingridient(value))
      });
    }
    _product.ingredients=ingrs;
    Map<String, dynamic> returnMap ={
      "product" : _product,
      "shops" : shops
    };
    return returnMap;
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

  ///функция на вход получает id магазина и выводит информацию по этому магазину
  getShopById(String id) async{
    late shop newShop;
    await FirebaseFirestore.instance.collection("shops").doc(id).get().then((value) => {
      newShop = shop(value)
    });
      List<shop_location> shopLocations = [];
      final tempRef = FirebaseFirestore.instance.collection("shops").doc(newShop.id);
      await FirebaseFirestore.instance.collection("shop_locations").where("shop",isEqualTo: tempRef).get().then((value) => {
        value.docs.forEach((element) {
          shopLocations.add(shop_location.fromDoc(element));
        })
      });
      newShop.locations = shopLocations;
    return newShop;
  }

  ///функция на вход получает id продукта и выводит информацию об этом продукте
  getProductById(String id) async{
    late product newProduct;
    List<products_ingridients> prodIngr=[];
    await FirebaseFirestore.instance.collection("products").doc(id).get().then((value) => {
      newProduct = product(value)
    });
    final ref = FirebaseFirestore.instance.collection("products").doc(id);
    await FirebaseFirestore.instance.collection("products_ingridients").where("product_id",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        prodIngr.add(products_ingridients.fromDoc(element));
      })
    });
    List<ingridient> ingrs = [];
    for (int i=0;i<prodIngr.length;i++){
      await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
        ingrs.add(ingridient(value))
      });
    }
    newProduct.ingredients=ingrs;
    return newProduct;
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

  ///функция на вход получает id категории и выводит информацию  о всех продуктах для этой категории и все связи записи связанные с этими продуктами из таблицы product-ingridient
  ///Возращает карту где mapName["products"] - лист продуктов, а mapName["products_ingridients"] - лист из соответствующей таблицы.
  getProductsByCategory(String categoryId) async{
    List<product> products = [];
    List<products_ingridients> prodIngr = [];
    final ref = FirebaseFirestore.instance.collection("categories").doc(categoryId);
    await FirebaseFirestore.instance.collection("products").where("category",isEqualTo: ref).get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
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
    for(int j=0;j<products.length;j++){
      List<ingridient> ingrs = [];
      for (int i=0;i<prodIngr.length;i++){
        if (prodIngr[i].product_id.toString().contains(products[j].id)){
          await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
            ingrs.add(ingridient(value))
          });
        }
      }
      products[j].ingredients=ingrs;
    }
    Map<String,dynamic> newmap = {
      "products" : products,
      "products_ingridients" : prodIngr,
    };
    return newmap;
  }

  ///функция на вход получает id продукта и выводит информацию о всех продуктах из категории, к которой относиться продукт и все записи связанные с этими продуктами из таблицы product-ingridient
  getAllProductsInCategory(String productId) async{
    List<product> products = [];
    List<products_ingridients> prodIngr=[];
    late product newProduct;
    await FirebaseFirestore.instance.collection("products").doc(productId).get().then((value) => {
      newProduct=product(value)
    });
    await FirebaseFirestore.instance.collection("products").where("category",isEqualTo: newProduct.category).get().then((value) => {
      value.docs.forEach((element) {
        products.add(product.fromDoc(element));
      })
    });
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
    for(int j=0;j<products.length;j++){
      List<ingridient> ingrs = [];
      for (int i=0;i<prodIngr.length;i++){
        if (prodIngr[i].product_id.toString().contains(products[j].id)){
          await FirebaseFirestore.instance.collection("ingridients").doc(prodIngr[i].ingridient_id.id).get().then((value) => {
            ingrs.add(ingridient(value))
          });
        }
      }
      products[j].ingredients=ingrs;
    }
    Map<String,dynamic> newmap = {
      "products" : products,
      "products_ingridients" : prodIngr,
    };
    return newmap;
  }


}