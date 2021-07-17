import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Admin/Model/address.dart';
import 'package:web_firebase/Admin/Order/widget/order_detail_card.dart';
import 'package:web_firebase/Admin/Order/widget/status_banner.dart';
import 'package:web_firebase/Admin/Order/widget/user_address.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/Widgets/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.SHADOW_RED1,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Text(
            "Detail de la commande",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Signatra",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("adminOrders")
                .doc(widget.orderID)
                .get(),
            builder: (_, snapshot) {
              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          StatusBanner(
                            status: snapshot.data!.get('isSuccess'),
                          ),

                          //Address with barcode
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.orderBy)
                                .collection("userAddress")
                                .doc(widget.addressID)
                                .get(),
                            builder: (_, snapshotDoc) {
                              return snapshotDoc.hasData
                                  ? UserAddress(
                                      model: AddressModel.fromDocument(
                                          snapshotDoc.data!),
                                      id: widget.orderBy.toString(),
                                    )
                                  : Center(child: CircularProgressIndicator(color: Colors.green,));
                            },
                          ),
                          Divider(),
                          // les produits de commande
                          FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("adminOrders")
                                .doc(widget.orderBy)
                                .collection("adminOrdersCart")
                                .where("shortInfo",
                                    whereIn: snapshot.data!
                                        .get(EcommerceApp.productID))
                                .get(),
                            builder: (_, snap) {
                              return snap.hasData
                                  ? OrderDetailCard(
                                      itemCount: snap.data!.docs.length,
                                      snapshotData: snap.data!.docs,
                                    )
                                  : Center(child: CircularProgressIndicator(color: Colors.green,));
                            },
                          ),

                          // total amount
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
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
                            ),
                          ),

                          // Date de commande et reference mobile money
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  'Date de commande : ' +
                                      DateFormat("dd MMMM, yyyy - hh:mm aa")
                                          .format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(
                                            snapshot.data!.get('orderTime'),
                                          ),
                                        ),
                                      ),
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Nom mobile money : ' +
                                      snapshot.data!.get('nomMobileMoney'),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Numero de reference : ' +
                                      snapshot.data!.get('reference'),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  confirmeParcelShifted(
                                      context,
                                      widget.orderID.toString(),
                                      snapshot.data!.get('orderBy'));
                                },
                                child: Container(
                                  decoration: new BoxDecoration(
                                    gradient: new LinearGradient(
                                      colors: [
                                        AppColors.GREEN,
                                        AppColors.GREEN
                                      ],
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width - 40.0,
                                  height: 50.0,
                                  child: Center(
                                    child: Text(
                                      "Confirmer la commande",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator(color: Colors.green,));
            }),
      ),
    );
  }

  confirmeParcelShifted(BuildContext context, String mOrderId, String userUid) {
    // supprimer/confirmer les commandes du client/Id
      FirebaseFirestore.instance
        .collection("adminOrders")
        .doc(mOrderId)
        .delete();


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
