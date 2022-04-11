import 'package:flutter/material.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/shopPage.dart';
import 'package:tea_web/catalogPage.dart';

import 'dbEntities/dbFunctions.dart';
import 'dbEntities/ingredient.dart';
import 'dbEntities/product.dart';

class MyApp extends StatelessWidget {
  final String idProduct;

  const MyApp(this.idProduct, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatchMaterialColor,
          // accentColor: Colors.red,
        ),
      ),
      home: productPage(idProduct),
    );
  }
}

class productPage extends StatefulWidget {
  static String _idProduct = "";

  static PageRouteBuilder getRoute(String idProduct) {
    _idProduct = idProduct;
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return productPage(idProduct);
    });
  }

  const productPage(String idProduct, {Key? key}) : super(key: key);

  @override
  State<productPage> createState() => _productPageState(_idProduct);
}

class _productPageState extends State<productPage> {
  String idProduct;

  _productPageState(this.idProduct);

  dbFunctions dbFuncs = dbFunctions();

  List<product> currentProduct = [];
  List<ingridient> currentIngredients = [];
  Map<String, dynamic> currentInfoAboutShops = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text("Продукт"),
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
            buildFutureBuilderPartOfProduct(),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
              child: Divider(
                thickness: 1,
                color: thirdColor,
              ),
            ),
            buildFutureBuilderPartOfIngredients(),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
              child: Divider(
                thickness: 1,
                color: thirdColor,
              ),
            ),
            buildFutureBuilderPartOfShops(),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilderPartOfProduct() {
    return FutureBuilder(
        future: dbFuncs.getProductById(idProduct),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            currentProduct = [];
            currentProduct.add(snapshot.data! as product);
            return buildPartOfProduct();
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildPartOfProduct() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.network(
                "${currentProduct[0].image}",
                width: 180,
                fit: BoxFit.contain,
              ),
            ),
            // Container(
            //   height: 150,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.vertical,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text("___________________"),
            //         Text(
            //           "Ingredients:",
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         Text(
            //           "Tie Guan Yin oolong,",
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         Text(
            //           "Thai mango,",
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         Text(
            //           "flavoring.",
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         Text("___________________"),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, catalogPage.getRoute("", "", idProduct));
                },
                child: Text("Открыть ${currentProduct[0].name} в сетке каталога"))),
        Padding(
          padding: const EdgeInsets.only(
              bottom: 4.0, left: 16.0, right: 16.0, top: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Icon(
                //   Icons.star_border,
                //   size: 20,
                // ),
                Text(
                  "${currentProduct[0].name}",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
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
            color: thirdColor
            ,
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
                "${currentProduct[0].description}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFutureBuilderPartOfIngredients() {
    return FutureBuilder(
        future: dbFuncs.getIngredientsByProduct(idProduct),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            currentIngredients = [];
            currentIngredients = snapshot.data! as List<ingridient>;
            return buildPartOfIngredients();
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildPartOfIngredients() {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ингредиенты",
              style:
              TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Container(
              height: currentIngredients.length*24,
              width: MediaQuery.of(context).size.width - 32,
              child: ListView.builder(
                  itemCount: currentIngredients.length,
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                return Text(
                  "${currentIngredients[index].name.toLowerCase()}",
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilderPartOfShops() {
    return FutureBuilder(
        future: dbFuncs.getShopInfoByProduct(idProduct),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            currentInfoAboutShops = {};
            currentInfoAboutShops = snapshot.data! as Map<String, dynamic>;
            return buildPartOfShops(currentInfoAboutShops);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildPartOfShops(Map<String, dynamic> infoAboutShops) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: Container(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: infoAboutShops['shops'].length,
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(secondColor),
                    ),
                    padding: EdgeInsets.only(
                      left: 1.0,
                      right: 1.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            minVerticalPadding: 0,
                            title: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, shopPage.getRoute(infoAboutShops['shops'][index].id));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: index == 0
                                        ? Radius.circular(20)
                                        : Radius.circular(0),
                                    bottomLeft: index == 0
                                        ? Radius.circular(20)
                                        : Radius.circular(0),
                                    topRight: index == infoAboutShops['shops'].length - 1
                                        ? Radius.circular(20)
                                        : Radius.circular(0),
                                    bottomRight: index == infoAboutShops['shops'].length - 1
                                        ? Radius.circular(20)
                                        : Radius.circular(0),
                                  ),
                                  color: firstColor,
                                  border: Border.all(
                                    width: 2,
                                    color: Color(secondColor),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "${infoAboutShops['shops'][index].image}",
                                    width: 10,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
