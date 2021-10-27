import 'package:flutter/material.dart';

import 'package:web_firebase/Widgets/colors.dart';

class UploadBarLateral extends StatelessWidget {
  final Function() saveData;

  const UploadBarLateral({
    Key? key,
    required this.saveData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 100,
            color: AppColors.SHADOW_RED1,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/homePage');
                    },
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    )),
                Text(
                  'Accueil',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Center(
            child: Text('Ajouter nouveau produit',
                style: TextStyle(color: Colors.white)),
          ),
          Center(
            child: Row(
              children: [
                Tooltip(
                  message: 'Enregistrer',
                  child: IconButton(
                    onPressed: this.saveData,
                    icon: Icon(Icons.save, color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
