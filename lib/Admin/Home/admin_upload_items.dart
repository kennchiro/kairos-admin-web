import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Widgets/colors.dart';

class UploadItems extends StatefulWidget {
  @override
  _UploadItemsState createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems>
    with AutomaticKeepAliveClientMixin<UploadItems> {
  @override
  bool get wantKeepAlive => true;

  var _descriptionTextEditingController = TextEditingController();
  var _priceTextEditingController = TextEditingController();
  var _titleTextEditingController = TextEditingController();
  var _shortInfoTextEditingController = TextEditingController();
  String? _categoryTextEditingController;
  String? _etatTextEditingController;
  var _reductionTextEditingController = TextEditingController();

  static const categoryItems = <String>[
    'Pizza',
    'Tacos',
    'Mi-Sao',
    'Soupe',
    'Assiette de sambos',
    'Autres'
  ];

  // etat
  static const etatItems = <String>[
    'Disponible',
    'Non disponible',
  ];

  String? fileImage;
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  clearFormInfo() {
    setState(() {
      fileImage = null;
      _descriptionTextEditingController.clear();
      _priceTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _reductionTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    
    if(_shortInfoTextEditingController.text.isNotEmpty && 
    _descriptionTextEditingController.text.isNotEmpty && 
    _priceTextEditingController.text.isNotEmpty && 
    _titleTextEditingController.text.isNotEmpty &&
    _reductionTextEditingController.text.isNotEmpty){
      saveItemInfo(fileImage!);
    } else {
      EasyLoading.showInfo("Veuillez remplir toutes les champs");
    }
    
  }

  saveItemInfo(String downloadUrl) {
    final itemsRef = FirebaseFirestore.instance.collection("Items");
    itemsRef.doc(productId).set({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "longDescription": _descriptionTextEditingController.text.trim(),
      "price": int.parse(_priceTextEditingController.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim(),
      "category": _categoryTextEditingController!.trim(),
      "etat": _etatTextEditingController!.trim(),
      "reduction": _reductionTextEditingController.text.trim(),
    }).whenComplete(() {
       EasyLoading.showSuccess("Ajoute avec succes");
       Route route = MaterialPageRoute(builder: (c) => HomePage());
       Navigator.pushReplacement(context, route);
    });

    setState(() {
      fileImage = null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _reductionTextEditingController.clear();
    });
  }

  uploadImageFromPc() {
    final input = FileUploadInputElement()..accept = 'image/*';
    input.click();
    FirebaseStorage fs = FirebaseStorage.instance;

    input.onChange.listen((event) {
      final file = input.files?.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) async {
        var snapshot = fs.ref().child('Items');
        UploadTask uploadTask =  snapshot.child("product_$productId.jpg").putBlob(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        setState(() {
          fileImage = downloadUrl;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.SHADOW_RED1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                clearFormInfo();
                Route route = MaterialPageRoute(builder: (c) => HomePage());
                Navigator.pushReplacement(context, route);
              },
            ),
            title: Center(
              child: Text(
                "Nouveau produit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed:
                          uploading ? null : () => uploadImageAndSaveItemInfo(),
                    ),
                  ),
                 
                ],
              ),
            ]),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            uploading ? CircularProgressIndicator() : Text(''),
            Container(
              height: 300.0,
              width: 400,
              child: Center(
                child: fileImage == null
                    ? Placeholder(
                        fallbackHeight: 200,
                        fallbackWidth: 300,
                      )
                    : Container(
                        height: 200,
                        child: Image.network(
                          fileImage!,
                          fit: BoxFit.fill,
                          height: 200,
                          width: 300,
                        )),
              ),
            ),
            SizedBox(height: 5),
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                uploadImageFromPc();
              },
              child:
                  Text("Prendre une photo", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 12),
            //title of product
            ListTile(
                title: Container(
              width: 250.0,
              child: TextFormField(
                  style: TextStyle(color: AppColors.DARK),
                  controller: _titleTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.title,
                      color: Colors.grey,
                    ),
                    hintText: "Titre",
                    labelText: "Titre (Pizza, Tacos...)",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  )),
            )),

            //short info of product
            ListTile(
                title: Container(
              width: 250.0,
              child: TextFormField(
                  style: TextStyle(color: AppColors.DARK),
                  controller: _shortInfoTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_device_information,
                      color: Colors.grey,
                    ),
                    hintText: "Short Info",
                    labelText: "Short Info (Jambon-poulet, Margherita...)",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  )),
            )),

            //price
            ListTile(
                title: Container(
              width: 250.0,
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: AppColors.DARK),
                  controller: _priceTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                    hintText: "Prix",
                    labelText: "Prix en Ariary",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  )),
            )),

            // category dropdown
            ListTile(
              title: Text('Categorie',
                  style: TextStyle(
                    color: AppColors.DARK,
                  )),
              trailing: new DropdownButton<String>(
                items: categoryItems.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _categoryTextEditingController,
                hint: const Text('choisi'),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoryTextEditingController = newValue!;
                  });
                },
              ),
            ),

            // etat dropdown
            ListTile(
              title: Text('Etat', style: TextStyle(color: AppColors.DARK)),
              trailing: DropdownButton<String>(
                items: etatItems.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _etatTextEditingController,
                hint: const Text('choisi'),
                onChanged: (String? newValue) {
                  setState(() {
                    _etatTextEditingController = newValue!;
                  });
                },
              ),
            ),

            //reduction
            ListTile(
                title: Container(
              width: 250.0,
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: AppColors.DARK),
                  controller: _reductionTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                    hintText: "Reduction %",
                    labelText: "Reduction",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  )),
            )),

            //description of product
            ListTile(
                title: Container(
              width: 250.0,
              child: TextFormField(
                  maxLines: 4,
                  style: TextStyle(color: AppColors.DARK),
                  controller: _descriptionTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.description,
                      color: Colors.grey,
                    ),
                    hintText: "Description",
                    labelText: "Description",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  )),
            ))
          ]),
        ));
  }
}
