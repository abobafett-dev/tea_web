import 'package:flutter/material.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/shopPage.dart';
import 'package:tea_web/catalogPage.dart';

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
      home: const productPage(),
    );
  }
}

class productPage extends StatefulWidget {
  static PageRouteBuilder getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return productPage();
    });
  }

  const productPage({Key? key}) : super(key: key);

  @override
  State<productPage> createState() => _productPageState();
}

class _productPageState extends State<productPage> {
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
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

Widget buildEmptyBodyShopPage(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.asset(
                  "assets/images/product_image_example.png",
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("___________________"),
                      Text(
                        "Ingredients:",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Tie Guan Yin oolong,",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Thai mango,",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "flavoring.",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text("___________________"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
              child:
                  ElevatedButton(onPressed: () {
                    Navigator.push(context, catalogPage.getRoute());
                  }, child: Text("Open in web"))),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(
                    Icons.star_border,
                    size: 40,
                  ),
                  Text(
                    "Oolong with mango",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
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
                const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oolong with mango",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "recept",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "recept",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "recept",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
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
                const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "description drcription rwerw3escription terger description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
