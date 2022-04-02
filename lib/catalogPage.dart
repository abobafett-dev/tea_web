import 'package:flutter/material.dart';
import 'package:tea_web/dbEntities/dbFunctions.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/shopPage.dart';
import 'package:tea_web/main.dart';
import 'package:tea_web/productPage.dart';
import 'package:tea_web/graph_example.dart';

import 'dbEntities/product.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatchMaterialColor,
          // accentColor: Colors.red,
        ),
      ),
      home: const catalogPage(),
    );
  }
}

class catalogPage extends StatefulWidget {
  static PageRouteBuilder getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return catalogPage();
    });
  }

  const catalogPage({Key? key}) : super(key: key);

  @override
  State<catalogPage> createState() => _catalogPageState();
}

class _catalogPageState extends State<catalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context, shopPage.getRoute());
            }),
      ),
      backgroundColor: firstColor,
      body: buildEmptyBodyShopPage(context),
      bottomNavigationBar: buildBottomNavigationBarForCatalogPage(context),
    );
  }

  Widget buildEmptyBodyShopPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, LayerGraphPageFromJson.getRoute());
              },
            child: Text("example"),
          ),
        ),
      ],
    );
  }
}

dbFunctions functions = new dbFunctions();

Widget buildBottomNavigationBarForCatalogPage(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Color(secondColor),
    ),
    height: 210,
    child: Column(
      children: [
        Container(
          color: thirdColor,
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Oolong with mango",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "Ingredients: Tie Guan Yin oolong, Thai mango, flavoring",
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, productPage.getRoute());
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Show more...",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, mainPage.getRoute());
                },
                icon: const Icon(
                  Icons.home_outlined,
                  size: 40,
                )),
          ],
        ),
      ],
    ),
  );
}
