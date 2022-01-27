import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Client/Provider/ClientProvider.dart';
import 'package:web_firebase/Admin/Client/widget/client_shipping_details.dart';
import 'package:web_firebase/Admin/Client/widget/client_status_banner.dart';
import 'package:web_firebase/Admin/Model/address.dart';
import 'package:web_firebase/Admin/Order/widget/details_paiement.dart';
import 'package:web_firebase/Admin/Order/widget/dialogFormMotif.dart';
import 'package:web_firebase/Admin/Order/widget/order_detail_card.dart';
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
          future: Provider.of<ClientProvider>(context, listen: false)
              .getOrderAndUserByID(this.widget.userUid, this.widget.orderID),
          builder: (context, snapshotOr) {
            List listCart = snapshotOr.data!.get('userCartList');
            return snapshotOr.hasData
                ? Container(
                    child: Column(
                      children: [
                        ClientStatusBanner(
                          status: snapshotOr.data!.get('isSuccess'),
                        ),
                        // Adresse + qrCode
                        FutureBuilder<DocumentSnapshot>(
                            future: Provider.of<ClientProvider>(context,
                                    listen: false)
                                .getAddressByID(this.widget.userUid,snapshotOr.data!.get('addressID')),
                            builder: (context, snapshotAd) {
                              return snapshotAd.hasData
                                  ? ClientShippingDetails(
                                      userUID: this.widget.userUid,
                                      model: AddressModel.fromDocument(
                                          snapshotAd.data!),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ));
                            }),

                              //commandes
                              snapshotOr.hasData
                                  ? OrderDetailCard(
                                      itemCount: listCart.length,
                                      snapshotData: listCart,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.green,
                                    )),
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

                        Divider(),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Provider.of<ClientProvider>(context, listen: false).confirmeParcelShifted(
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
                                    Provider.of<ClientProvider>(context, listen: false).cancelOrder(
                                      context, 
                                      this.widget.orderID,
                                      this.widget.userUid,
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
          },
        ),
      ),
    );
  }

}
