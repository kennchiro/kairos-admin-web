import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  final String menuName;
  final Widget menuWidget;

  const MenuListTile({ required this.menuName, required this.menuWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.menuWidget,
      title: Text(this.menuName,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          )),
      onTap: () {},
    );
  }
}
