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

  Graph graph = Graph()..isTree = true;

  dbFunctions dbFuncs = dbFunctions();

  // var relationshipsGraphExample = {
  //   "edges": [
  //     {"from": "7045321", "to": "308264215"},
  //     {"from": "308264215", "to": "205893853"},
  //     {"from": "205893853", "to": "7045321"},
  //   ]
  // };

  var relationshipsGraph = {"edges": []};

  Map<String, product> currentProducts = {};

  String isFocusedProduct = "";

  @override
  Widget build(BuildContext context) {
    if(filters[2] != ""){
      isFocusedProduct = "DocumentReference<Map<String, dynamic>>(products/${filters[2]})";
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Каталог"),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: thirdColor,
                ),
                onPressed: () {
                  setState(() {});
                },
                child: Icon(Icons.refresh)),
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
      bottomNavigationBar: isFocusedProduct != ""
          ? buildFutureBuilderPartOfBottomNavigationBarForCatalogPage(context)
          : Container(height: 1,),
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
              var info = snapshot.data! as Map<String, dynamic>;
              List mapToEdges = [];
              bool wasBefore = false;
              info['products_ingridients'].forEach((first_element) {
                info['products_ingridients'].forEach((second_element) {
                  if (first_element != second_element &&
                      first_element.ingridient_id ==
                          second_element.ingridient_id) {
                    mapToEdges.forEach((element) {
                      if ((element['from'] ==
                                  first_element.product_id.toString() &&
                              element['to'] ==
                                  second_element.product_id.toString()) ||
                          ((element['to'] ==
                                  first_element.product_id.toString() &&
                              element['from'] ==
                                  second_element.product_id.toString()))) {
                        wasBefore = true;
                        return;
                      }
                    });
                    if (wasBefore == false) {
                      mapToEdges.add({
                        "from": first_element.product_id.toString(),
                        "to": second_element.product_id.toString()
                      });
                    }
                    wasBefore = false;
                  }
                });
              });
              info['products'].forEach((element) {
                currentProducts[
                        "DocumentReference<Map<String, dynamic>>(products/${element.id})"] =
                    element;
              });
              relationshipsGraph['edges'] = mapToEdges;
              initState();
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
              var info = snapshot.data! as Map<String, dynamic>;
              List mapToEdges = [];
              bool wasBefore = false;
              info['products_ingridients'].forEach((first_element) {
                info['products_ingridients'].forEach((second_element) {
                  if (first_element != second_element &&
                      first_element.ingridient_id ==
                          second_element.ingridient_id) {
                    mapToEdges.forEach((element) {
                      if ((element['from'] ==
                                  first_element.product_id.toString() &&
                              element['to'] ==
                                  second_element.product_id.toString()) ||
                          ((element['to'] ==
                                  first_element.product_id.toString() &&
                              element['from'] ==
                                  second_element.product_id.toString()))) {
                        wasBefore = true;
                        return;
                      }
                    });
                    if (wasBefore == false) {
                      mapToEdges.add({
                        "from": first_element.product_id.toString(),
                        "to": second_element.product_id.toString()
                      });
                    }
                    wasBefore = false;
                  }
                });
              });
              info['products'].forEach((element) {
                currentProducts[
                        "DocumentReference<Map<String, dynamic>>(products/${element.id})"] =
                    element;
              });
              relationshipsGraph['edges'] = mapToEdges;
              initState();
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
              var info = snapshot.data! as Map<String, dynamic>;
              List mapToEdges = [];
              bool wasBefore = false;
              info['products_ingridients'].forEach((first_element) {
                info['products_ingridients'].forEach((second_element) {
                  if (first_element != second_element &&
                      first_element.ingridient_id ==
                          second_element.ingridient_id) {
                    mapToEdges.forEach((element) {
                      if ((element['from'] ==
                                  first_element.product_id.toString() &&
                              element['to'] ==
                                  second_element.product_id.toString()) ||
                          ((element['to'] ==
                                  first_element.product_id.toString() &&
                              element['from'] ==
                                  second_element.product_id.toString()))) {
                        wasBefore = true;
                        return;
                      }
                    });
                    if (wasBefore == false) {
                      mapToEdges.add({
                        "from": first_element.product_id.toString(),
                        "to": second_element.product_id.toString()
                      });
                    }
                    wasBefore = false;
                  }
                });
              });
              info['products'].forEach((element) {
                currentProducts[
                        "DocumentReference<Map<String, dynamic>>(products/${element.id})"] =
                    element;
              });
              relationshipsGraph['edges'] = mapToEdges;
              initState();
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

  // int sortComparison(Map<String, dynamic> a, Map<String, dynamic> b){
  //   if(a['from'] == b['from']){
  //
  //   }
  // }

  Widget buildGraphView(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(1000),
              minScale: 0.0001,
              maxScale: 10000,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rectangleWidget(String? a, Node node) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 450),
      child: Container(
        color: Colors.amber,
        child: InkWell(
          onTap: () {
            isFocusedProduct = a!;
            setState(() {});
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                        color:
                            isFocusedProduct == a ? Colors.orange : thirdColor,
                        spreadRadius: 1),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                        child: Image.network(
                      "${currentProducts[a]!.image}",
                      height: isFocusedProduct == a ? 40 : 30,
                      width: isFocusedProduct == a ? 40 : 30,
                    )),
                  ],
                ),
              ),
              // Text("${a}"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    List edges = [];
    // edges = relationshipsGraphExample['edges']!;
    if (relationshipsGraph['edges']!.length > 0) {
      edges = relationshipsGraph['edges']!;
      graph = Graph()..isTree = true;
    }
    edges.forEach((element) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    });
  }

  Widget buildFutureBuilderPartOfBottomNavigationBarForCatalogPage(
      BuildContext context) {
    String id_product = isFocusedProduct.substring(
        isFocusedProduct.indexOf('/') + 1, isFocusedProduct.indexOf(')'));
    return FutureBuilder(
        future: dbFuncs.getProductById(id_product),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            var currentProduct = snapshot.data! as product;
            return buildBottomNavigationBarForCatalogPage(currentProduct);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        });
    return Container();
  }

  Widget buildBottomNavigationBarForCatalogPage(product currentProduct) {
    String ingredients = "";
    for (var ingredient in currentProduct.ingredients!) {
      ingredients += ingredient.name.toLowerCase() + ", ";
    }
    ingredients = ingredients.substring(0, ingredients.length - 2);
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${currentProduct.name}",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      "Ингредиенты: ${ingredients}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, productPage.getRoute(currentProduct.id));
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
