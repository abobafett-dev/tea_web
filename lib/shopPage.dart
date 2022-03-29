import 'package:flutter/material.dart';
import 'package:tea_web/dbEntities/dbFunctions.dart';
import 'package:tea_web/productPage.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/mainPage.dart';
import 'package:tea_web/catalogPage.dart';

import 'dbEntities/shop.dart';

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
      home: const shopPage(),
    );
  }
}

class shopPage extends StatefulWidget {
  static PageRouteBuilder getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return shopPage();
    });
  }

  const shopPage({Key? key}) : super(key: key);

  @override
  State<shopPage> createState() => _shopPageState();
}

class _shopPageState extends State<shopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context, mainPage.getRoute());
            }),
      ),
      backgroundColor: firstColor,
      body: buildEmptyBodyShopPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

Widget buildEmptyBodyShopPage(BuildContext context) {
  //example for FutureBuilder and shop
  dbFunctions functions = dbFunctions();
  late shop _shop;
  FutureBuilder( ///для обработки 1 магаза
    future: functions.getShopById('fHB98eHLNQQrlU5rfuPa'), ///id Кантаты, по идее должно передаваться сюда при нажатии на выбранный где-то магаз.
    builder: (context, snapshot){
      if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.done) {
        _shop = snapshot.data as shop;
        /// return то, что использует данные полученые из запроса, должно находится внутри Future Builder
      }
      return Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ));
    },
  );


  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset(
                      "assets/images/shop_logo_example.png",
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
                          Text("___________________"),
                          Text(
                            "+7 (982) 961-05-90",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "www.cantata.ru",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "vk.com/cantata",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "+7 (982) 961-05-90",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "www.cantata.ru",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "vk.com/cantata",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "+7 (982) 961-05-90",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "www.cantata.ru",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "vk.com/cantata",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "+7 (982) 961-05-90",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "www.cantata.ru",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "vk.com/cantata",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "+7 (982) 961-05-90",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "www.cantata.ru",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "vk.com/cantata",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("___________________"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, catalogPage.getRoute());
              }, child: Text("Open web")),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.star_border,
                  size: 40,
                ),
                Text(
                  "Cantata",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                ),
              ],
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
                const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
            child: Text(
              "Most popular",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: firstColor,
              ),
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, productPage.getRoute());
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
                            Icon(
                              Icons.star,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text(
                              "product name",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, productPage.getRoute());
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
                            Icon(
                              Icons.star,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text(
                              "product name",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, productPage.getRoute());
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
                            Icon(
                              Icons.star,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text(
                              "product name",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, productPage.getRoute());
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
                            Icon(
                              Icons.star,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text(
                              "product name",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, productPage.getRoute());
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
                            Icon(
                              Icons.star,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text(
                              "product name",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
            child: Text(
              "Located",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "st. 50 years of October, 14",
                        style: TextStyle(fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF52958B),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      child: Text(
                        "st. 50 years of October, 14",
                        style: TextStyle(fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF52958B),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      child: Text(
                        "st. 50 years of October, 14",
                        style: TextStyle(fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF52958B),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      child: Text(
                        "st. 50 years of October, 14",
                        style: TextStyle(fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF52958B),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      child: Text(
                        "st. 50 years of October, 14",
                        style: TextStyle(fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF52958B),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      child: Text(
                        "st. 50 years of October, 14",
                        style: TextStyle(fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF52958B),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          )),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
