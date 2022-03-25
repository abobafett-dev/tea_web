import 'package:flutter/material.dart';
import 'package:tea_web/widgetFunctions.dart';

void main() => runApp(const MyApp());

const MaterialColor primarySwatchMaterialColor =
    MaterialColor(0xFF51795e, <int, Color>{
  50: Color(0xFF51795e),
  100: Color(0xFF51795e),
  200: Color(0xFF51795e),
  300: Color(0xFF51795e),
  400: Color(0xFF51795e),
  500: Color(0xFF51795e),
  600: Color(0xFF51795e),
  700: Color(0xFF51795e),
  800: Color(0xFF51795e),
  900: Color(0xFF51795e),
});

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 30,
              )),
          Container(
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
        ],
      )),
      body: Column(
        children: const [],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
