import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Order/Provider/OrderProvider.dart';
import 'package:web_firebase/Admin/Order/widget/order_bar_lateral.dart';
import 'package:web_firebase/Admin/Order/widget/order_card.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/my_scaffold.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
                      stream: Provider.of<OrderProvider>(context, listen: false)
                          .initAdminOrder(),
                      builder: (_, snapshot) {
                        return LayoutBuilder(builder: (context, constraint) {
                          if (constraint.maxWidth > 768) {
                            return snapshot.hasData
                                ? GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 4,
                                    children: List.generate(
                                        snapshot.data!.docs.length, (index) {
                                      var dataMap = snapshot.data!.docs[index];
                                      List listCart = dataMap.get('userCartList');                                    
                                            return snapshot.hasData
                                                ? OrderCard(
                                                    itemCount: listCart.length,
                                                    snapshotData: listCart,
                                                    //
                                                    orderID: dataMap.reference.id,
                                                    orderBy: dataMap.get('orderBy'),
                                                    addressID: dataMap.get('addressID'),
                                                    //
                                                    dateCom: dataMap.get('orderTime'),
                                                    nomPropre: dataMap.get('proprietaire'),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Colors.green,
                                                  ));
                                    }),
                                  )
                                : Center(
                                    child: Text("Il n'y a pas de commande"));
                          } else {
                            return snapshot.hasData
                                ? ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return FutureBuilder<QuerySnapshot>(
                                          future: FirebaseFirestore.instance
                                              .collection("adminOrders")
                                              .doc(snapshot.data!.docs[index]
                                                  .get('orderBy'))
                                              .collection("adminOrdersCart")
                                              .where("shortInfo",
                                                  whereIn: snapshot
                                                      .data!.docs[index]
                                                      .get(EcommerceApp
                                                          .productID))
                                              .get(),
                                          builder: (_, snap) {
                                            return snap.hasData
                                                ? OrderCard(
                                                    itemCount:
                                                        snap.data!.docs.length,
                                                    snapshotData:
                                                        snap.data!.docs,
                                                    //
                                                    orderID: snapshot
                                                        .data!
                                                        .docs[index]
                                                        .reference
                                                        .id,
                                                    orderBy: snapshot
                                                        .data!.docs[index]
                                                        .get('orderBy'),
                                                    addressID: snapshot
                                                        .data!.docs[index]
                                                        .get('addressID'),
                                                    //
                                                    dateCom: snapshot
                                                        .data!.docs[index]
                                                        .get('orderTime'),
                                                    nomPropre: snapshot
                                                        .data!.docs[index]
                                                        .get('proprietaire'),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.green,
                                                    ),
                                                  );
                                          });
                                    },
                                  )
                                : Center(
                                    child: Text("Il n'y a pas de commande"));
                          }
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
