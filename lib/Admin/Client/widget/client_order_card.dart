import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_firebase/Admin/Client/client_order_details.dart';
import 'package:web_firebase/Admin/Model/cart.dart';
import 'package:web_firebase/Admin/Order/widget/item_product_card_order.dart';
import 'package:web_firebase/Widgets/colors.dart';

class ClientOrderCard extends StatelessWidget {
  final int itemCount;
  final List<dynamic> snapshotData;
  final String orderID;
  final String orderBy;
  final String dateCom;


  const ClientOrderCard({
    Key? key,
    required this.itemCount,
    required this.snapshotData,
    required this.orderID,
    required this.orderBy,
    required this.dateCom,
  }) : super(key: key);

  redirecTo(BuildContext context) {
    Route route;
    route = MaterialPageRoute(
      builder: (_) => ClientOrderDetails(
        orderID: this.orderID,
        userUid: this.orderBy,
      ),
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        redirecTo(context);
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
              builder: (_) => ClientOrderDetails(
                orderID: this.orderID,
                userUid: this.orderBy,
              ),
            );
            Navigator.push(context, route);
          },
          child: Row(
            children: [
              Text(
                '- Date : ' +
                    DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(dateCom),
                      ),
                    ),
                style: TextStyle(color: Colors.white, fontSize: 10),
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
              shrinkWrap: true,
              itemCount: itemCount,
              scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                CartModel cartmodel =
                    CartModel.fromJson(snapshotData[index]);
                return ItemProductCardOrder(
                  cartmodel: cartmodel,
                  redirecTo: () => redirecTo(context),
                );
              }),
        ),
      ),
    );
  }
}
