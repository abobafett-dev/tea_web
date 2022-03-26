import 'package:flutter/material.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/mainPage.dart';

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
                  "assets/images/Kantata_logo.png",
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
                      Navigator.push(context, shopPage.getRoute());
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
                      Navigator.push(context, shopPage.getRoute());
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
                      Navigator.push(context, shopPage.getRoute());
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
                      Navigator.push(context, shopPage.getRoute());
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
                      Navigator.push(context, shopPage.getRoute());
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                      child: Container(
                        child: Text(
                          "st. 50 years of October, 14",
                          style: TextStyle(fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF7a925c),
                            border: Border.all(color: Color(0xFF62754a),width: 1,)
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                      child: Container(
                        child: Text(
                          "st. 50 years of October, 14",
                          style: TextStyle(fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF7a925c),
                            border: Border.all(color: Color(0xFF62754a),width: 1,)
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                      child: Container(
                        child: Text(
                          "st. 50 years of October, 14",
                          style: TextStyle(fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF7a925c),
                            border: Border.all(color: Color(0xFF62754a),width: 1,)
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                      child: Container(
                        child: Text(
                          "st. 50 years of October, 14",
                          style: TextStyle(fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF7a925c),
                            border: Border.all(color: Color(0xFF62754a),width: 1,)
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ],
      ),
    ),
  );
}
