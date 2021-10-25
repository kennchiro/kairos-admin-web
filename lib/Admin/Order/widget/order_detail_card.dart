import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:web_firebase/Admin/Model/cart.dart';
import 'package:web_firebase/Admin/Order/widget/item_product_card_order.dart';
import 'package:web_firebase/Widgets/colors.dart';

class OrderDetailCard extends StatelessWidget {

  final int itemCount;
  final List<DocumentSnapshot> snapshotData;

  const OrderDetailCard({
    Key? key,
    required this.itemCount,
    required this.snapshotData,
  }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
   return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.LIGHT_GREEN,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: itemCount * 150.0,
        child: ListView.builder(
            itemCount: itemCount,
            scrollDirection: Axis.vertical,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              CartModel cartmodel =
                  CartModel.fromDocument(snapshotData[index]);
              return ItemProductCardOrder(
                cartmodel: cartmodel, 
                redirecTo: ()=> print(snapshotData.toString())
              ,);
            }),
      ),
    );
  }
}
