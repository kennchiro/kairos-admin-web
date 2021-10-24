import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Order/widget/order_bar_lateral.dart';
import 'package:web_firebase/Admin/Order/widget/order_card.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/Widgets/colors.dart';
import 'package:web_firebase/my_scaffold.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  emptyOrderUser() {
    return Container(
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

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      route: '/orderPage',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OrderBarLateral(),
            //
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  
                  StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance.collection("adminOrders").snapshots(),
                      builder: (_, snapshot) {
                        return LayoutBuilder(builder: (context, constraint) {
                          return snapshot.hasData
                              ? GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: constraint.maxWidth < 768 ? 1 : 3,
                                  children:
                                      List.generate(snapshot.data!.docs.length, (index) {
                                    return FutureBuilder<QuerySnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection("adminOrders")
                                            .doc(snapshot.data!.docs[index].get('orderBy'))
                                            .collection("adminOrdersCart")
                                            .where("shortInfo",
                                                whereIn: snapshot.data!.docs[index]
                                                    .get(EcommerceApp.productID))
                                            .get(),
                                        builder: (_, snap) {
                                          return snap.hasData
                                              ? OrderCard(
                                                  itemCount: snap.data!.docs.length,
                                                  snapshotData: snap.data!.docs,
                                                  //
                                                  orderID: snapshot
                                                      .data!.docs[index].reference.id,
                                                  orderBy: snapshot.data!.docs[index]
                                                      .get('orderBy'),
                                                  addressID: snapshot.data!.docs[index]
                                                      .get('addressID'),
                                                  //
                                                  dateCom: snapshot.data!.docs[index]
                                                      .get('orderTime'),
                                                  nomPropre: snapshot.data!.docs[index]
                                                      .get('proprietaire'),
                                                )
                                              : Center(
                                                  child: CircularProgressIndicator(
                                                  color: Colors.green,
                                                ));
                                        });
                                  }))
                              : Center(child: emptyOrderUser());
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
