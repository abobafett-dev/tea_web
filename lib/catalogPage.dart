import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:tea_web/dbEntities/dbFunctions.dart';
import 'additionalThings/projectColors.dart';
import 'additionalThings/widgetFunctions.dart';
import 'package:tea_web/shopPage.dart';
import 'package:tea_web/main.dart';
import 'package:tea_web/productPage.dart';
import 'package:tea_web/graph_example.dart';

import 'dbEntities/product.dart';

class MyApp extends StatelessWidget {
  final String _idCategory;
  final String _idShop;
  final String _idProduct;

  const MyApp(this._idCategory, this._idShop, this._idProduct, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatchMaterialColor,
          // accentColor: Colors.red,
        ),
      ),
      home: catalogPage(_idCategory, _idShop, _idProduct),
    );
  }
}

class catalogPage extends StatefulWidget {
  static String _idCategory = "";
  static String _idShop = "";
  static String _idProduct = "";

  static PageRouteBuilder getRoute(
      String idCategory, String idShop, String idProduct) {
    _idCategory = idCategory;
    _idShop = idShop;
    _idProduct = idProduct;

    return PageRouteBuilder(
        transitionsBuilder: (_, animation, secondAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, pageBuilder: (_, __, ___) {
      return catalogPage(idCategory, idShop, idProduct);
    });
  }

  const catalogPage(String idCategory, String idShop, String idProduct,
      {Key? key})
      : super(key: key);

  @override
  State<catalogPage> createState() =>
      _catalogPageState(_idCategory, _idShop, _idProduct);
}

class _catalogPageState extends State<catalogPage> {
  List<String> filters = [];

  _catalogPageState(String idCategory, String idShop, String idProduct) {
    this.filters = [idCategory, idShop, idProduct];
  }

  var builder = FruchtermanReingoldAlgorithm(iterations: 1000);

  final Graph graph = Graph()..isTree = true;

  dbFunctions dbFuncs = dbFunctions();

  var relationshipsGraphExample = {
    "edges": [
      {"from": "7045321", "to": "308264215"},
      {"from": "308264215", "to": "205893853"},
      {"from": "205893853", "to": "7045321"},
    ]
  };

  var relationshipsGraph = {"edges": []};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        title: Row(
          children: [
            Text("Каталог"),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(context, LayerGraphPageFromJson.getRoute());
            //   },
            //   child: Text("example"),
            //   style: ElevatedButton.styleFrom(
            //     primary: thirdColor,
            //   ),
            // ),
          ],
        ),
      ),
      backgroundColor: firstColor,
      body: buildFutureBuilderPartOfGraph(filters),
      // bottomNavigationBar: buildBottomNavigationBarForCatalogPage(context),
    );
  }

  Widget buildFutureBuilderPartOfGraph(List<String> filters) {
    ///idCategory
    if (filters[0] != "") {
      return FutureBuilder(
          future: dbFuncs.getProductsByCategory(filters[0]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return buildGraphView(context);
            }

            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          });
    }

    ///idShop
    else if (filters[1] != "") {
      return FutureBuilder(
          future: dbFuncs.getProductsByShop(filters[1]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return buildGraphView(context);
            }

            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          });
    }

    ///idProduct
    else if (filters[2] != "") {
      return FutureBuilder(
          future: dbFuncs.getAllProductsInCategory(filters[2]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return buildGraphView(context);
            }

            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          });
    }

    return Container();
  }

  Widget buildGraphView(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Wrap(
          //   children: [
          //     Container(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.nodeSeparation.toString(),
          //         decoration: InputDecoration(labelText: 'Node Separation'),
          //         onChanged: (text) {
          //           builder.nodeSeparation = int.tryParse(text) ?? 100;
          //           this.setState(() {});
          //         },
          //       ),
          //     ),
          //     Container(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.levelSeparation.toString(),
          //         decoration: InputDecoration(labelText: 'Level Separation'),
          //         onChanged: (text) {
          //           builder.levelSeparation = int.tryParse(text) ?? 100;
          //           this.setState(() {});
          //         },
          //       ),
          //     ),
          //     Container(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.orientation.toString(),
          //         decoration: InputDecoration(labelText: 'Orientation'),
          //         onChanged: (text) {
          //           builder.orientation = int.tryParse(text) ?? 100;
          //           this.setState(() {});
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.1,
                maxScale: 100,
                child: GraphView(
                  graph: graph,
                  algorithm: builder,
                  paint: Paint()
                    ..color = secondColorColor
                    ..strokeWidth = 1
                    ..style = PaintingStyle.fill,
                  builder: (Node node) {
                    // I can decide what widget should be shown here based on the id
                    var a = node.key!.value;
                    return rectangleWidget(a, node);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget rectangleWidget(String? a, Node node) {
    return Container(
      color: Colors.amber,
      child: InkWell(
        onTap: () {
          print('clicked');
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: thirdColor, spreadRadius: 1),
                ],
              ),
              child: Container(
                  child: Image.asset(
                "assets/images/product_image_example.png",
                height: 50,
                width: 50,
              )),
            ),
            // Text("${a}"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    var edges = relationshipsGraphExample['edges']!;
    edges.forEach((element) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    });

    // builder
    //   ..nodeSeparation = (100)
    //   ..levelSeparation = (100)
    //   ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  Widget buildBottomNavigationBarForCatalogPage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(secondColor),
      ),
      height: 150,
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
                      Navigator.push(context, productPage.getRoute(""));
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //         onPressed: () {
          //           Navigator.push(context, mainPage.getRoute());
          //         },
          //         icon: const Icon(
          //           Icons.home_outlined,
          //           size: 40,
          //         )),
          //   ],
          // ),
        ],
      ),
    );
  }
}
