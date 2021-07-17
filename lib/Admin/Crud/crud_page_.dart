import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Crud/Category/category_page.dart';
import 'package:web_firebase/Admin/Crud/Category/widget/category_item.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Widgets/colors.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.SHADOW_RED1,
      elevation: 0,
      title: Center(
        child: Text(
          "Produit par Categorie",
          style: TextStyle(color: Colors.white),
        ),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => HomePage());
            Navigator.pushReplacement(context, route);
          }),
    ),
    body:  CategoryItem((categoryName) {
          Route route = MaterialPageRoute(
              builder: (c) => CategoryPage(
                    categoryName: categoryName,
                  ));
          Navigator.pushReplacement(context, route);
        }),
      );
  }
}
