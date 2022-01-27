import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Client/Provider/ClientProvider.dart';
import 'package:web_firebase/Admin/Client/widget/client_order_card.dart';
import 'package:web_firebase/Widgets/colors.dart';
import 'package:web_firebase/my_scaffold.dart';

class ClientOrder extends StatelessWidget {
  final String uid;
  final String username;
  final int countOrder;
  final String emailUser;

  const ClientOrder({
    Key? key,
    required this.uid,
    required this.username,
    required this.countOrder,
    required this.emailUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        route: '',
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // bar
              Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      color: AppColors.SHADOW_RED1,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/clientPage');
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
                    Center(
                      child: Text(
                        'Commande ${this.countOrder}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Client : ${this.username} - ${this.emailUser}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // order
              SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream:
                            Provider.of<ClientProvider>(context, listen: false)
                                .getOrderUserByID(this.uid),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {

                                var dataMap = snapshot.data!.docs[index];
                                List listCart = dataMap.get('userCartList');

                                return snapshot.hasData
                                    ? ClientOrderCard(
                                        itemCount: listCart.length,
                                        snapshotData: listCart,
                                        //
                                        orderID: dataMap.reference.id,
                                        orderBy: this.uid,
                                        dateCom: dataMap.get('orderTime'),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ));
                              });
                        })
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
