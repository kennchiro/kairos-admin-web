import 'package:flutter/material.dart';
import 'package:web_firebase/Widgets/colors.dart';

class Couverture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.SHADOW_RED1,
          image: DecorationImage(
            image: AssetImage("images/admin.png"),
            fit: BoxFit.fill,
          )),
      child: Container(
        height: 200,
        padding: EdgeInsets.only(top: 24.0, bottom: 10.0),
        color: Colors.black12.withOpacity(0.1),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "KAIROS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
