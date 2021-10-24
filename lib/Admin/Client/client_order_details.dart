import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:web_firebase/Admin/Client/client_page.dart';
import 'package:web_firebase/Admin/Client/widget/client_order.dart';

import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Admin/Model/address.dart';
import 'package:web_firebase/Admin/Order/widget/details_paiement.dart';
import 'package:web_firebase/Admin/Order/widget/dialogFormMotif.dart';
import 'package:web_firebase/Admin/Order/widget/order_detail_card.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/Widgets/colors.dart';
import 'package:web_firebase/my_scaffold.dart';

String getOrderId = "";

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
    getOrderId = this.widget.orderID;

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
                        StatusBanner(
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
                                  ? ShippingDetails(
                                      model: AddressModel.fromDocument(
                                          snapshotAd.data!),
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
                                      getOrderId,
                                      this.widget.userUid,
                                    );
                                  },
                                  child: Text(
                                    'Confimer commande',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  color: Colors.green,
                                ),

                                // annuler la commande
                                DialogFormMotif(
                                  motifController: motifText,
                                  okFormMotif: () {
                                    cancelOrder(context, getOrderId,
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
    });

    Route route = MaterialPageRoute(builder: (c) => HomePage());
    Navigator.pushReplacement(context, route);
    EasyLoading.showSuccess("Commande confirmé avec succès");
  }
}

class StatusBanner extends StatelessWidget {
  final bool status;


  const StatusBanner({
    Key? key,
    required this.status,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message;
    IconData iconData;


    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? message = 'succès' : message = 'Unsuccessful';

    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Container(
            height: 50,
            width: 100,
            color: AppColors.SHADOW_RED1,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Route route;
                      route = MaterialPageRoute(
                        builder: (_) => ClientPage(),
                      );
                      Navigator.pushReplacement(context, route);
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
                Text(
                  'retour',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          //
          Center(
            child: Row(
              children: [
                Text(
                  'Commande a été passée avec $message',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColors.WHITE,
                    child: Center(
                      child: Icon(
                        iconData,
                        color: AppColors.GREEN,
                        size: 14,
                      ),
                    )),
              ],
            ),
          ),

          Text(''),
        ],
      ),
    );
  }
}

class ShippingDetails extends StatefulWidget {
  final AddressModel model;

  const ShippingDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _ShippingDetailsState createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String formateDate = DateFormat('EEE d MMM').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Supplier address
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.model.name!,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Text("${widget.model.flatNumber}, ${widget.model.quartier}",
                    style: TextStyle(fontSize: 11)),
                Text("${widget.model.city}", style: TextStyle(fontSize: 11)),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Text("${widget.model.phoneNumber}",
                    style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Text('ID', style: TextStyle(fontSize: 11)),
                Container(
                  height: 50,
                  width: 50,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: getOrderId,
                  ),
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text(formateDate + ', Fianarantsoa',
                    style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
        SizedBox(height: 1 * PdfPageFormat.cm),
      ],
    );
  }
}
