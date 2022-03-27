import 'package:flutter/material.dart';
import 'package:tea_web/additionalThings/widgetFunctions.dart';
import 'additionalThings/projectColors.dart';
import 'shopPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatchMaterialColor,
        ),
      ),
      home: const mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  static PageRouteBuilder getRoute() {
    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return mainPage();
    });
  }

  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: buildTitleAppBarMainPage(context),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.view_headline,
              size: 35,
            )),
      ),
      body: buildEmptyBodyMainPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

Widget buildTitleAppBarMainPage(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF51635e),
            spreadRadius: 3,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text(
            "Search shops",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
          Icon(
            Icons.search,
            size: 40,
          )
        ],
      ),
    ),
  );
}

Widget buildEmptyBodyMainPage(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Most popular",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0, bottom: 2.0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        SingleChildScrollView(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(context, shopPage.getRoute());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "New",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0, bottom: 2.0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        SingleChildScrollView(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(context, shopPage.getRoute());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: firstColor,
                        border: Border.all(
                          width: 2,
                          color: Color(secondColor),
                        ),
                      ),
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/shop_logo_example.png",
                          width: 10,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: 8.0, left: 8.0, top: 16.0, bottom: 4.0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(200),
              child: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 90,
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(200),
              child: Icon(
                Icons.help,
                color: Colors.black,
                size: 90,
              ),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0, bottom: 2.0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}
