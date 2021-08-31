import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Crud/Category/category_page.dart';
import 'package:web_firebase/Admin/Crud/Category/widget/category_item.dart';
import 'package:web_firebase/my_scaffold.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
    route: '/productPage',
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
