import 'package:flutter/material.dart';

import 'package:web_firebase/Admin/Model/cart.dart';
import 'package:web_firebase/Widgets/colors.dart';

class ItemProductCardOrder extends StatelessWidget {
  final CartModel cartmodel;
  final Function() redirecTo;

  const ItemProductCardOrder({
    Key? key,
    required this.cartmodel,
    required this.redirecTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialButton(
      padding: const EdgeInsets.all(0),
      elevation: 5.0,
      color: AppColors.WHITE,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      onPressed: this.redirecTo,
      child: Row(
        children: [
          Ink(
            height: 110,
            width: 100,
            child: Image.network(
              this.cartmodel.thumbnailUrl!,
              width: 100.0,
              height: 110.0,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 185,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        this.cartmodel.title!,
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        // model.shortInfo
                        this.cartmodel.shortInfo!,
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        // model.price
                        "Prix : " + (this.cartmodel.price.toString()) + " Ar",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.SHADOW,
                        ),
                        child: Text(
                          this.cartmodel.quantity! > 1
                              ? "quantités : ${this.cartmodel.quantity}"
                              : "quantité : ${this.cartmodel.quantity}",
                          style: TextStyle(fontSize: 13, color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
