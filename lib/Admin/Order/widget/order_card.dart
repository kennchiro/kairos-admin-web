import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_firebase/Admin/Model/cart.dart';
import 'package:web_firebase/Admin/Order/order_details_page.dart';
import 'package:web_firebase/Admin/Order/widget/item_product_card_order.dart';
import 'package:web_firebase/Widgets/colors.dart';

class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot<Object?>> snapshotData;
  final String orderID;
  final String addressID;
  final String orderBy;
  final String dateCom;
  final String nomPropre;

  const OrderCard({
    Key? key,
    required this.itemCount,
    required this.snapshotData,
    required this.orderID,
    required this.addressID,
    required this.orderBy,
    required this.dateCom,
    required this.nomPropre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Route route;
        route = MaterialPageRoute(
          builder: (_) => OrderDetailPage(
              orderID: orderID, orderBy: orderBy, addressID: addressID),
        );
        Navigator.push(context, route);
      },
      child: Badge(
        elevation: 0,
        shape: BadgeShape.square,
        animationDuration: const Duration(milliseconds: 800),
        animationType: BadgeAnimationType.fade,
        position: BadgePosition.bottomEnd(bottom: 13, end: 13),
        badgeColor: AppColors.LIGHT_GREEN,
        badgeContent: InkWell(
          onTap: () {
            Route route;
            route = MaterialPageRoute(
                builder: (_) => OrderDetailPage(
                    orderID: orderID, orderBy: orderBy, addressID: addressID));
            Navigator.push(context, route);
          },
          child: Row(
            children: [
              Text("Client : " + nomPropre, style: TextStyle(color: Colors.white)),
                SizedBox(width: 5),
              Text(
                '- Date : ' +
                    DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(dateCom),
                      ),
                    ),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
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
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                CartModel cartmodel =
                    CartModel.fromDocument(snapshotData[index]);
                return ItemProductCardOrder(cartmodel: cartmodel);
              }),
        ),
      ),
    );
  }
}
