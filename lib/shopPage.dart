import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tea_web/dbEntities/dbFunctions.dart';
import 'package:tea_web/dbEntities/ingredient.dart';
import 'package:tea_web/dbEntities/shop.dart';
import 'package:tea_web/dbEntities/shop_location.dart';
import 'package:tea_web/productPage.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/main.dart';
import 'package:tea_web/catalogPage.dart';
import 'package:tea_web/additionalThings/projectColors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dbEntities/product.dart';
import 'dbEntities/shop.dart';
import 'dbEntities/shop.dart';

class MyApp extends StatelessWidget {
  final String idShop;

  const MyApp(this.idShop, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatchMaterialColor,
          // accentColor: Colors.red,
        ),
      ),
      home: shopPage(idShop),
    );
  }
}

class shopPage extends StatefulWidget {
  static String _idShop = "";

  static PageRouteBuilder getRoute(String idShop) {
    _idShop = idShop;
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return shopPage(idShop);
    });
  }

  const shopPage(String idShop, {Key? key}) : super(key: key);

  @override
  State<shopPage> createState() => _shopPageState(_idShop);
}

class _shopPageState extends State<shopPage> {
  String idShop;
  _shopPageState(this.idShop);

  dbFunctions dbFuncs = dbFunctions();

  List<shop> currentShop = [];
  List<product> popularProductsInShop = [];
  List<shop_location> locationsOfShop = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text("Магазин"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      backgroundColor: firstColor,
      body: buildEmptyBodyShopPage(context),
    );
  }

  Widget buildEmptyBodyShopPage(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFutureBuilderPartOfShop(),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
              child: Divider(
                thickness: 1,
                color: Colors.white70,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
              child: Text(
                "Популярные продукты",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            buildFutureBuilderPartOfPopularProducts(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
              child: Text(
                "Где находится",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            buildFutureBuilderPartOfLocationsOfShop(),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilderPartOfShop() {
    return FutureBuilder(
        future: dbFuncs.getShopById(idShop),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            currentShop = [];
            currentShop.add(snapshot.data! as shop);
            return buildPartOfShop();
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildPartOfShop() {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(
                    "${currentShop[0].image}",
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        currentShop[0].phone_number.isNotEmpty
                            ? Text(
                                "${currentShop[0].phone_number}",
                                style: TextStyle(fontSize: 18),
                              )
                            : Container(),
                        currentShop[0].website.isNotEmpty
                            ? InkWell(
                                onTap: () async {
                                  String url = "${currentShop[0].website}";
                                  if (await canLaunch(url)) {
                                    await launch(url, forceWebView: true);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Не удалось открыть ${url}'),
                                    ));
                                  }
                                },
                                child: Icon(
                                  Icons.language,
                                  size: 50,
                                ),
                              )
                            : Container(),
                        currentShop[0].vk.isNotEmpty
                            ? InkWell(
                                onTap: () async {
                                  String url = "${currentShop[0].vk}";
                                  if (await canLaunch(url)) {
                                    await launch(url, forceWebView: true);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Не удалось открыть ${url}'),
                                    ));
                                  }
                                },
                                child: Image.asset(
                                  "assets/images/icon_vk.png",
                                  height: 50,
                                  width: 50,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, catalogPage.getRoute("", idShop, ""));
                },
                child: Text("Открыть ${currentShop[0].name} в сетке каталога")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0, top: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.star_border,
                size: 40,
              ),
              Text(
                "${currentShop[0].name}",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFutureBuilderPartOfPopularProducts() {
    return FutureBuilder(
        future: dbFuncs.getProductsLimit(idShop, 10),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            popularProductsInShop = [];
            popularProductsInShop = snapshot.data! as List<product>;
            return buildPartOfPopularProductsListView(popularProductsInShop);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildPartOfPopularProductsListView(
      List<product> popularProductsInShop) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularProductsInShop.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        productPage.getRoute(popularProductsInShop[index].id));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: thirdColor,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    width: 100,
                    height: 120,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Image.network(
                            "${popularProductsInShop[index].image}",
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            "${popularProductsInShop[index].name.toUpperCase()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  Widget buildFutureBuilderPartOfLocationsOfShop() {
    return FutureBuilder(
        future: dbFuncs.getShopLocations(idShop),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            locationsOfShop = [];
            locationsOfShop = snapshot.data! as List<shop_location>;
            return buildPartOfLocationsOfShops(locationsOfShop);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildPartOfLocationsOfShops(List<shop_location> locationsOfShop) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        height: locationsOfShop.length < 3
            ? 20 * locationsOfShop.length.toDouble()
            : 90,
        child: ListView.builder(
            itemCount: locationsOfShop.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF52958B),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    )),
                child: Text(
                  "${locationsOfShop[index].location}",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }),
      ),
    );
  }
}
