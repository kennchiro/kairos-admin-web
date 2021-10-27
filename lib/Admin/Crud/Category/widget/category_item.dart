import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Function(String) onTapes;
  CategoryItem(this.onTapes);

  final List<String> categoryList = [
    'Pizza',
    'Tacos',
    'Mi-Sao',
    'Soupe',
    'Assiette de sambos',
    'Autres'
  ];

  final List<String> categoryImage = [
    'images/Pizza.png',
    'images/Tacos.png',
    'images/Spaghetti.png',
    'images/Soupe.png',
    'images/Nachos.png',
    'images/Autres.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: LayoutBuilder(builder: (context, constraint) {
            return GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: constraint.maxWidth > 768 ? 2 : 3,
              children: List.generate(
                categoryList.length,
                (index) {
                  String listCat = categoryList[index];
                  return GestureDetector(
                    onTap: () => onTapes(listCat),
                    child: Column(children: [
                      Card(
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                    categoryImage[index],
                                  ),
                                  fit: BoxFit.cover)),
                          width: 150,
                          height: 150.0,
                        ),
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      Text(
                        listCat,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ]),
                  );
                },
              ),
            );
          })),
    );
  }
}
