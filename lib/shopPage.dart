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
      body: buildEmptyBodyShopPage(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

Widget buildEmptyBodyShopPage(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      children: [
        Text("123"),
      ],
    ),
  );
}
