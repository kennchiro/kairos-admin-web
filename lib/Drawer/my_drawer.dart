import 'package:flutter/material.dart';
import 'package:web_firebase/Drawer/widget/couverture.dart';
import 'package:web_firebase/Drawer/widget/menu_list_tile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Couverture(),
          SizedBox(height: 9),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuListTile(
                  menuName: "Client",
                  menuWidget: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.person_pin_sharp)),
                ),
                MenuListTile(
                  menuName: "Commande",
                  menuWidget: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.reorder)),
                ),
                MenuListTile(
                  menuName: "Produit",
                  menuWidget: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.archive)),
                ),
                MenuListTile(
                  menuName: "Ajout nouveau produit",
                  menuWidget: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.add)),
                ),
                MenuListTile(
                  menuName: "Déconnexion",
                  menuWidget: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.power_settings_new)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
