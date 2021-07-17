import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_firebase/Admin/Crud/Category/widget/alert_delete.dart';
import 'package:web_firebase/Admin/Crud/Category/widget/item_image.dart';
import 'package:web_firebase/Admin/Crud/crud_page_.dart';
import 'package:web_firebase/Widgets/colors.dart';

class CategoryPage extends StatefulWidget {
  final String? categoryName;
  CategoryPage({this.categoryName});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final shortController = new TextEditingController();
  String? etatController;
  final reductionController = new TextEditingController();
  final description = new TextEditingController();
  final prix = new TextEditingController();

  static const etatItems = <String>[
   'Disponible',
   'Indisponible',
  ];

  @override
  void initState() {
    initSearch();
    countCategName();
    super.initState();
  }

  //count each product of category
  int _countProd = 0;
  int get count => _countProd;
  Future<void> countCategName() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection("Items")
        .where('category', isEqualTo: this.widget.categoryName!)
        .get();
    List<DocumentSnapshot> _docSnap = _myDoc.docs;
    setState(() {
      _countProd = _docSnap.length;
    });
  }

  late Future<QuerySnapshot> documentList;
  Future initSearch() async {
    documentList = FirebaseFirestore.instance
        .collection('Items')
        .where('category', isEqualTo: this.widget.categoryName!)
        .get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.SHADOW_RED1,
        title: Center(
          child: Text(this.widget.categoryName!,
              style: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => CrudPage());
              Navigator.pushReplacement(context, route);
            }),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 40),
              alignment: Alignment.center,
              child: Text(count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20)))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot>(
          future: documentList,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              default:
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: new ListView(
                    padding: EdgeInsets.only(bottom: 80),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: AlertDialog(
                                        title: Text(
                                          "Modifier produit " +
                                              document['title'].toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // short Info
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: "Titre"),
                                              controller:
                                                  TextEditingController()
                                                    ..text =
                                                        document['shortInfo']
                                                            .toString(),
                                              onChanged: (text) {
                                                setState(() {
                                                  shortController.text = text;
                                                });
                                              },
                                            ),

                                            //prix
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: "Prix en ariary"),
                                              controller:
                                                  TextEditingController()
                                                    ..text = document['price']
                                                        .toString(),
                                              onChanged: (text) {
                                                setState(() {
                                                  prix.text = text;
                                                });
                                              },
                                            ),

                                            //Reduction
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: "Reduction"),
                                              controller:
                                                  TextEditingController()
                                                    ..text =
                                                        document['reduction']
                                                            .toString(),
                                              onChanged: (text) {
                                                setState(() {
                                                  reductionController.text =
                                                      text;
                                                });
                                              },
                                            ),

                                            // description
                                            TextFormField(
                                              maxLines: 4,
                                              decoration: const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: "Description"),
                                              controller:
                                                  TextEditingController()
                                                    ..text = document[
                                                            'longDescription']
                                                        .toString(),
                                              onChanged: (text) {
                                                setState(() {
                                                  description.text = text;
                                                });
                                              },
                                            ),

                                            //etat
                                            ListTile(
                                              title: Text('Etat',
                                                  style: TextStyle(
                                                      color: AppColors.DARK)),
                                              trailing: DropdownButton<String>(
                                                items: etatItems
                                                    .map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                value: etatController,
                                                hint:
                                                    Text('${document['etat']}'),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    etatController = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Annuler",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          // Update Button
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                            onPressed: () {
                                              var updateProduct =
                                                  new Map<String, dynamic>();
                                              updateProduct["shortInfo"] =
                                                  shortController.text.isEmpty
                                                      ? document['shortInfo']
                                                          .toString()
                                                      : shortController.text;
                                              updateProduct["reduction"] =
                                                  reductionController
                                                          .text.isEmpty
                                                      ? document['reduction']
                                                          .toString()
                                                      : reductionController
                                                          .text;
                                              updateProduct["etat"] =
                                                  etatController == null
                                                      ? document['etat']
                                                          .toString()
                                                      : etatController;
                                              updateProduct["price"] =
                                                  prix.text.isEmpty
                                                      ? document['price']
                                                      : int.parse(prix.text);
                                              updateProduct["longDescription"] =
                                                  description.text.isEmpty
                                                      ? document[
                                                              'longDescription']
                                                          .toString()
                                                      : description.text;

                                              // Update Firestore record information regular way
                                              FirebaseFirestore.instance
                                                  .collection("Items")
                                                  .doc(document.reference.id)
                                                  .update(updateProduct)
                                                  .then((value) {
                                                EasyLoading.showSuccess(
                                                    "Modification avec succes");
                                                Route route = MaterialPageRoute(
                                                  builder: (c) => CrudPage());
                                              Navigator.pushReplacement(
                                                  context, route);
                                              });
                                            },
                                            child: Text("OK",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            title: new Text(
                              "Titre : " + document['shortInfo'],
                              style: TextStyle(fontSize: 15),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "Prix : " + document['price'].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                ItemImage(
                                  image: document['thumbnailUrl'],
                                  width: 30,
                                  height: 30,
                                  padding: 1.0,
                                ),
                              ],
                            ),
                            trailing:
                                // Delete Button
                                InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDelete(
                                          name: document['title'],
                                          onDelete: () {
                                            // Firestore delete a record code
                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(document.reference.id)
                                                .delete()
                                                .whenComplete(() {
                                              EasyLoading.showSuccess(
                                                  "Suppression avec succes");
                                              Route route = MaterialPageRoute(
                                                  builder: (c) => CrudPage());
                                              Navigator.pushReplacement(
                                                  context, route);
                                            });
                                          });
                                    });
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 36,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
