
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_firebase/Admin/Client/widget/client_shipping_details.dart';
import 'package:web_firebase/Admin/Client/widget/client_status_banner.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Admin/Model/address.dart';
import 'package:web_firebase/Admin/Order/widget/details_paiement.dart';
import 'package:web_firebase/Admin/Order/widget/dialogFormMotif.dart';
import 'package:web_firebase/Admin/Order/widget/order_detail_card.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/my_scaffold.dart';


class ClientOrderDetails extends StatefulWidget {
  final String orderID;
  final String userUid;

  const ClientOrderDetails({
    Key? key,
    required this.orderID,
    required this.userUid,
  }) : super(key: key);

  @override
  _ClientOrderDetailsState createState() => _ClientOrderDetailsState();
}

class _ClientOrderDetailsState extends State<ClientOrderDetails> {
  final motifText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    motifText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return MyScaffold(
      route: '',
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(this.widget.userUid)
              .collection('orders')
              .doc(this.widget.orderID)
              .get(),
          builder: (context, snapshotOr) {
            return snapshotOr.hasData
                ? Container(
                    child: Column(
                      children: [
                        ClientStatusBanner(
                          status: snapshotOr.data!.get('isSuccess'),
                        ),
                        // Adresse + qrCode
                        FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(this.widget.userUid)
                                .collection('userAddress')
                                .doc(snapshotOr.data!.get('addressID'))
                                .get(),
                            builder: (context, snapshotAd) {
                              return snapshotAd.hasData
                                  ? ClientShippingDetails(
                                      userUID: this.widget.userUid,
                                      model: AddressModel.fromDocument(snapshotAd.data!),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ));
                            }),

                        //commandes
                        FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(this.widget.userUid)
                                .collection('userCartListOrdersMap')
                                .where("shortInfo",
                                    whereIn: snapshotOr.data!
                                        .get(EcommerceApp.productID))
                                .get(),
                            builder: (_, snap) {
                              return snap.hasData
                                  ? OrderDetailCard(
                                      itemCount: snap.data!.docs.length,
                                      snapshotData: snap.data!.docs,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ));
                            }),
                        Divider(),

                        //total
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                'Livraison : 2000 Ar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSansCondensed',
                                ),
                              ),
                              Text(
                                'Total : ' +
                                    snapshotOr.data!
                                        .get('totalAmount')
                                        .toString() +
                                    ' Ar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSansCondensed',
                                ),
                              ),
                            ],
                          ),
                        ),

                        //detail paiement
                        DetailPaiement(
                          orderTime: snapshotOr.data!.get('orderTime'),
                          expediteur: snapshotOr.data!.get('nomMobileMoney'),
                          reference: snapshotOr.data!.get('reference'),
                        ),

                        Divider(
                          
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    confirmeParcelShifted(
                                      context,
                                      this.widget.orderID,
                                      this.widget.userUid,
                                    );
                                  },
                                  child: Text(
                                    'Confimer commande ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  color: Colors.green,
                                ),

                                // annuler la commande
                                DialogFormMotif(
                                  motifController: motifText,
                                  okFormMotif: () {
                                    cancelOrder(
                                        context, 
                                        this.widget.orderID,
                                        this.widget.userUid);
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
          },
        ),
      ),
    );
  }

  //annuler la commande
  cancelOrder(BuildContext context, String mOrderId, String userUid) {
    // supprimer/confirmer les commandes du client/Id
    FirebaseFirestore.instance.collection("adminOrders").doc(mOrderId).delete();

    //Confirmer tous les commande dans le cart Map
    FirebaseFirestore.instance
        .collection("adminOrders")
        .doc(userUid)
        .collection("adminOrdersCart")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });

    //supprimer tous les commandes du client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("orders")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });

    // supprimer tous les commandes du client Map
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("userCartListOrdersMap")
        .get()
        .then((value) {
       for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });

    //envoyer la facture/message vers le client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("facture-message")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "facture": motifText.text.trim(),
      "Date-heure": DateTime.now().millisecondsSinceEpoch.toString(),
      "emoji": false,
      "notificationStatus": true
    });

    Route route = MaterialPageRoute(builder: (c) => HomePage());
    Navigator.pushReplacement(context, route);
    EasyLoading.showSuccess("Commande confirmé avec succès");
  }

  // confirmer la commande
  confirmeParcelShifted(BuildContext context, String mOrderId, String userUid) {
    // supprimer/confirmer les commandes du client/Id
    FirebaseFirestore.instance.collection("adminOrders").doc(mOrderId).delete();

    //Confirmer tous les commande dans le cart Map
    FirebaseFirestore.instance
        .collection("adminOrders")
        .doc(userUid)
        .collection("adminOrdersCart")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });

    //supprimer tous les commandes du client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("orders")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });

    // supprimer tous les commandes du client Map
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("userCartListOrdersMap")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });

    //envoyer la facture/message vers le client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("facture-message")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "facture":
          "Nous avons pris votre commande et payement, le livreur arrivera dans quelques minutes",
      "Date-heure": DateTime.now().millisecondsSinceEpoch.toString(),
      "emoji": true,
      "notificationStatus": true
    });

    Route route = MaterialPageRoute(builder: (c) => HomePage());
    Navigator.pushReplacement(context, route);
    EasyLoading.showSuccess("Commande confirmé avec succès");
  }
}

