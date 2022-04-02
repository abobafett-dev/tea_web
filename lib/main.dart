import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tea_web/additionalThings/widgetFunctions.dart';
import 'additionalThings/projectColors.dart';
import 'dbEntities/dbFunctions.dart';
import 'shopPage.dart';
import 'catalogPage.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
  bool isOpenedCategoriesMenu = false;
  bool isOpenedShopsMenu = false;
  dbFunctions dbFuncs = dbFunctions();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 450),
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 65,
            title: buildTitleAppBarMainPage(context),
            leading: isOpenedShopsMenu == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isOpenedCategoriesMenu = !isOpenedCategoriesMenu;
                      });
                    },
                    icon: Icon(
                      isOpenedCategoriesMenu == false
                          ? Icons.view_headline
                          : Icons.horizontal_rule,
                      size: 35,
                    ))
                : Container()),
        body: isOpenedCategoriesMenu == false
            ? isOpenedShopsMenu == false
                ? buildEmptyBodyMainPage(context)
                : buildShopsMenu(context)
            : buildCategoriesMenu(context),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  Widget buildTitleAppBarMainPage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: isOpenedCategoriesMenu == false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isOpenedShopsMenu == false ? Container() : Text("Choose shop"),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isOpenedShopsMenu = !isOpenedShopsMenu;
                      });
                    },
                    icon: Icon(
                      isOpenedShopsMenu == false
                          ? Icons.search
                          : Icons.search_off,
                      size: 35,
                    )),
              ],
            )
          : Text("Choose Category"),
    );
  }

  Widget buildCategoriesMenu(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(32.0),
            child: TextField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter your category',
                labelText: 'Search category',
              ),
            ),
          ),
          Container(
              color: firstColor,
              width: MediaQuery.of(context).size.width,
                child: Column(
                    children: [
                      Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, catalogPage.getRoute());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                                child: Text(
                                  "Tea",
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: secondColorColor,
                          width: 1,
                        )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                              },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Coffee",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Tea",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Coffee",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Tea",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Coffee",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Tea",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Coffee",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Tea",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Coffee",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Tea",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, catalogPage.getRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                              child: Text(
                                "Coffee",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: secondColorColor,
                              width: 1,
                            )),
                      ),
                    ],
                  ),
            ),
        ],
      ),
    );
  }

  Widget buildShopsMenu(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(32.0),
            child: TextField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter your shop',
                labelText: 'Search shop',
              ),
            ),
          ),
          Container(
            color: firstColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, shopPage.getRoute());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                        child: Text(
                          "Cantata",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: secondColorColor,
                        width: 1,
                      )),
                ),
              ],
            ),
          ),
        ],
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
                onTap: () {

                },
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
}

