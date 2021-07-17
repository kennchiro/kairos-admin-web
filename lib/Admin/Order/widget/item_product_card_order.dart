
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Model/cart.dart';
import 'package:web_firebase/Widgets/colors.dart';

class ItemProductCardOrder extends StatelessWidget {
  final CartModel? cartmodel;
  ItemProductCardOrder({
    Key? key,
    this.cartmodel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(1),
      child: Badge(
        animationDuration: const Duration(milliseconds: 800),
        animationType: BadgeAnimationType.scale,
        position: BadgePosition.topEnd(
          end: 10,
        ),
        elevation: 0,
        badgeColor: Colors.white,
        badgeContent: _badgeContent(),
          child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                height: 110,
                width: width,
                child: Row(
                  children: [
                    Image.network(
                      cartmodel!.thumbnailUrl!,
                      width: 100.0,
                      height: 90.0,
                    ),
                    SizedBox(
                      width: 1.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartmodel!.title!,
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      // model.shortInfo
                                      cartmodel!.shortInfo!,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Prix: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11.0,
                                            ),
                                          ),
                                          Text(
                                            // model.price
                                            (cartmodel!.price).toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                           Text(
                                            " Ar ",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      width: 90,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.SHADOW,
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: Text(
                                        "quantité : " +
                                            cartmodel!.quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //cart.dart
            ],
          ),
        ),
      ),
    );
  }

  Widget _badgeContent() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.redAccent,
      ),
      alignment: Alignment.center,
      width: 30.0,
      height: 30.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${cartmodel!.reduction}%",
              style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "OFF",
              style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
