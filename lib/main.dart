import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tea_web/additionalThings/widgetFunctions.dart';
import 'additionalThings/projectColors.dart';
import 'dbEntities/dbFunctions.dart';
import 'dbEntities/shop.dart';
import 'dbEntities/category.dart';
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
  dbFunctions dbFuncs = dbFunctions();

  bool isOpenedCategoriesMenu = false;
  bool isOpenedShopsMenu = false;

  List<shop> shops = [];
  List<shop> shopsToStay = [];
  TextEditingController shopToSearch = TextEditingController();

  List<category> categories = [];
  List<category> categoriesToStay = [];
  TextEditingController categoryToSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              isOpenedShopsMenu || isOpenedCategoriesMenu == false
                  ? buildEmptyBodyMainPage(context, screenHeight, screenWidth)
                  : Container(
                      height: 0,
                    ),
              isOpenedShopsMenu == true
                  ? buildShopsMenu(context, screenHeight, screenWidth)
                  : Container(
                      height: 0,
                    ),
              isOpenedCategoriesMenu == true
                  ? buildCategoriesMenu(context, screenHeight, screenWidth)
                  : Container(
                      height: 0,
                    ),
            ],
          ),
        ),
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
                isOpenedShopsMenu == false
                    ? Container(child: Text("Главная"))
                    : Text("Выберите магазин"),
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
          : Text("Выберите категорию продукта"),
    );
  }

  Widget buildEmptyBodyMainPage(BuildContext context, var screenHeight, var screenWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 0),
        height: isOpenedShopsMenu || isOpenedCategoriesMenu == true
            ? 0
            : screenHeight - 187,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            // const Text(
            //   "Most popular shops",
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            // ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0, bottom: 2.0),
            //   child: Divider(
            //     color: Colors.black,
            //     thickness: 1,
            //   ),
            // ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(20),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Color(secondColor),
            //       ),
            //       padding: EdgeInsets.only(
            //         left: 1.0,
            //         right: 1.0,
            //       ),
            //       child: Row(
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(context, shopPage.getRoute());
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(20),
            //                   bottomLeft: Radius.circular(20),
            //                 ),
            //                 color: firstColor,
            //                 border: Border.all(
            //                   width: 2,
            //                   color: Color(secondColor),
            //                 ),
            //               ),
            //               width: 100,
            //               height: 100,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Image.asset(
            //                   "assets/images/shop_logo_example.png",
            //                   width: 10,
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(context, shopPage.getRoute());
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 color: firstColor,
            //                 border: Border.all(
            //                   width: 2,
            //                   color: Color(secondColor),
            //                 ),
            //               ),
            //               width: 100,
            //               height: 100,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Image.asset(
            //                   "assets/images/shop_logo_example.png",
            //                   width: 10,
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(context, shopPage.getRoute());
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 color: firstColor,
            //                 border: Border.all(
            //                   width: 2,
            //                   color: Color(secondColor),
            //                 ),
            //               ),
            //               width: 100,
            //               height: 100,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Image.asset(
            //                   "assets/images/shop_logo_example.png",
            //                   width: 10,
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(context, shopPage.getRoute());
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 color: firstColor,
            //                 border: Border.all(
            //                   width: 2,
            //                   color: Color(secondColor),
            //                 ),
            //               ),
            //               width: 100,
            //               height: 100,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Image.asset(
            //                   "assets/images/shop_logo_example.png",
            //                   width: 10,
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(context, shopPage.getRoute());
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(20),
            //                   bottomRight: Radius.circular(20),
            //                 ),
            //                 color: firstColor,
            //                 border: Border.all(
            //                   width: 2,
            //                   color: Color(secondColor),
            //                 ),
            //               ),
            //               width: 100,
            //               height: 100,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Image.asset(
            //                   "assets/images/shop_logo_example.png",
            //                   width: 10,
            //                   fit: BoxFit.contain,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Text(
              "Магазины",
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
            buildFutureBuilderNewShops(),

            // Padding(
            //   padding:
            //       EdgeInsets.only(right: 8.0, left: 8.0, top: 16.0, bottom: 4.0),
            //   child: Divider(
            //     color: Colors.black,
            //     thickness: 1,
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     InkWell(
            //       onTap: () {},
            //       borderRadius: BorderRadius.circular(200),
            //       child: Icon(
            //         Icons.account_circle,
            //         color: Colors.black,
            //         size: 90,
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {},
            //       borderRadius: BorderRadius.circular(200),
            //       child: Icon(
            //         Icons.help,
            //         color: Colors.black,
            //         size: 90,
            //       ),
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0, bottom: 2.0),
            //   child: Divider(
            //     color: Colors.black,
            //     thickness: 1,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilderNewShops() {
    return Container(
      height: 140,
      child: FutureBuilder(
        future: dbFuncs.getShopsLimit(10),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<shop> shops = snapshot.data! as List<shop>;
            return buildNewShopsListView(shops);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        },
      ),
    );
  }

  Widget buildNewShopsListView(List<shop> shops) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: shops.length,
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
                              context, shopPage.getRoute(shops[index].id));
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
                              topRight: index == shops.length - 1
                                  ? Radius.circular(20)
                                  : Radius.circular(0),
                              bottomRight: index == shops.length - 1
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
                              "${shops[index].image}",
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
    );
  }

  Widget buildShopsMenu(BuildContext context, var screenHeight, var screenWidth) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 450),
      height: isOpenedShopsMenu == false
          ? 0
          : screenHeight - 175 + 65,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.all(32.0),
              child: TextField(
                controller: shopToSearch,
                onChanged: (String value) {
                  shopsToStay = [];
                  String shopSearch = value.toLowerCase();

                  shops.forEach((element) {
                    if (element.name.toLowerCase().contains(shopSearch)) {
                      shopsToStay.add(element);
                    }
                  });

                  setState(() {});
                },
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Введите название магазина',
                  labelText: 'Поиск магазина',
                ),
              ),
            ),
            buildFutureBuilderShopsMenu(context, screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilderShopsMenu(BuildContext context, var screenHeight, var screenWidth) {
    return FutureBuilder(
        future: dbFuncs.getShops(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            shops = [];
            shops = snapshot.data! as List<shop>;
            if (shopsToStay.length > 0 ||
                (shopToSearch.text.length > 0 && shopsToStay.length == 0)) {
              shops = shopsToStay;
            }
            return buildShopsMenuListView(shops, screenHeight, screenWidth);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildShopsMenuListView(List<shop> shops, var screenHeight, var screenWidth) {
    return Container(
      height: screenHeight - 175 - 64 - 69 + 65,
      child: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, shopPage.getRoute(shops[index].id));
            },
            child: Container(
              color: firstColor,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                        child: Text(
                          "${shops[index].name}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
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
          );
        },
      ),
    );
  }

  Widget buildCategoriesMenu(BuildContext context, var screenHeight, var screenWidth) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 450),
      height: isOpenedCategoriesMenu == false
          ? 0
          : screenHeight - 175 + 65,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.all(32.0),
              child: TextField(
                controller: categoryToSearch,
                onChanged: (String value) {
                  categoriesToStay = [];
                  String categoryToSearch = value.toLowerCase();

                  categories.forEach((element) {
                    if (element.name.toLowerCase().contains(categoryToSearch)) {
                      categoriesToStay.add(element);
                    }
                  });

                  setState(() {});
                },
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Введите название категории продуктов',
                  labelText: 'Поиск категории',
                ),
              ),
            ),
            buildFutureBuilderCategoriesMenu(context, screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilderCategoriesMenu(BuildContext context, var screenHeight, var screenWidth) {
    return FutureBuilder(
        future: dbFuncs.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            categories = [];
            categories = snapshot.data! as List<category>;
            if (categoriesToStay.length > 0 ||
                (categoryToSearch.text.length > 0 &&
                    categoriesToStay.length == 0)) {
              categories = categoriesToStay;
            }
            return buildCategoriesMenuListView(categories, screenHeight, screenWidth);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
  }

  Widget buildCategoriesMenuListView(List<category> categories, var screenHeight, var screenWidth) {
    return Container(
      height: screenHeight - 175 - 64 - 69 + 65,
      child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    catalogPage.getRoute(
                        categories[index].id, "", ""));
              },
              child: Container(
                color: firstColor,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
                            child: Text(
                              "${categories[index].name}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
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
            );
          }),
    );
  }
}
