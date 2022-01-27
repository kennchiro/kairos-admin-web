import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Client/Provider/ClientProvider.dart';
import 'package:web_firebase/Admin/Model/address.dart';
import 'package:web_firebase/Admin/Order/Provider/OrderProvider.dart';
import 'package:web_firebase/Admin/Order/widget/details_paiement.dart';
import 'package:web_firebase/Admin/Order/widget/dialogFormMotif.dart';
import 'package:web_firebase/Admin/Order/widget/order_detail_card.dart';
import 'package:web_firebase/Admin/Order/widget/status_banner.dart';
import 'package:web_firebase/Admin/Order/widget/user_address.dart';
import 'package:web_firebase/my_scaffold.dart';

class OrderDetailPage extends StatefulWidget {
  final String? orderID;
  final String? orderBy;
  final String? addressID;

  OrderDetailPage({
    Key? key,
    this.orderID,
    this.orderBy,
    this.addressID,
  }) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final motifText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      route: '/orderDetaillePage',
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: Provider.of<OrderProvider>(context, listen: false)
                .getOrderByID(this.widget.orderID),
            builder: (_, snapshot) {
              List listCart = snapshot.data!.get('userCartList');
              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          StatusBanner(
                            status: snapshot.data!.get('isSuccess'),
                          ),

                          //Address with barcode
                          FutureBuilder<DocumentSnapshot>(
                            future: Provider.of<ClientProvider>(context,
                                    listen: false)
                                .getAddressByID(
                                    widget.orderBy, widget.addressID),
                            builder: (_, snapshotDoc) {
                              return snapshotDoc.hasData
                                  ? UserAddress(
                                      model: AddressModel.fromDocument(
                                          snapshotDoc.data!),
                                      id: widget.orderBy.toString(),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ));
                            },
                          ),
                          Divider(),

                          // les produits de commande
                          snapshot.hasData
                              ? OrderDetailCard(
                                  itemCount: listCart.length,
                                  snapshotData: listCart,
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                ),

                          // total amount
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Livraison : 2000 Ar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Total : ' +
                                    snapshot.data!
                                        .get('totalAmount')
                                        .toString() +
                                    ' Ar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Date de commande et reference mobile money
                          //detail paiement
                          DetailPaiement(
                            orderTime: snapshot.data!.get('orderTime'),
                            expediteur: snapshot.data!.get('nomMobileMoney'),
                            reference: snapshot.data!.get('reference'),
                          ),

                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      Provider.of<ClientProvider>(context, listen: false).confirmeParcelShifted(
                                          context,
                                          widget.orderID.toString(),
                                          snapshot.data!.get('orderBy'));
                                    },
                                    child: Text(
                                      'Confimer commande ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    color: Colors.green,
                                  ),

                                  // annuler la commande
                                  DialogFormMotif(
                                    motifController: motifText,
                                    okFormMotif: () {
                                   Provider.of<ClientProvider>(context, listen: false).cancelOrder(
                                          context,
                                          widget.orderID.toString(),
                                          snapshot.data!.get('orderBy'),
                                          motifText,
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: Colors.green,
                    ));
            }),
      ),
    );
  }
}
