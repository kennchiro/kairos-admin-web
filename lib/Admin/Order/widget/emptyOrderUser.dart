import 'package:flutter/material.dart';
import 'package:web_firebase/Widgets/colors.dart';

class EmptyOrderUser extends StatelessWidget {
  const EmptyOrderUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Card(
            color: AppColors.LIGHT_GREY,
            child: Container(
                height: 80,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insert_emoticon, color: AppColors.GREEN),
                    Text("Il n'y a pas de commande"),
                  ],
                ))));
  }
}