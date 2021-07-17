import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Admin/Order/widget/order_card.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/Widgets/colors.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.SHADOW_RED1,
        elevation: 0,
        title: Center(
          child: Text(
            "Commandes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => HomePage());
              Navigator.pushReplacement(context, route);
            }),
        actions: [],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("adminOrders").snapshots(),
          builder: (_, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                        .collection("adminOrders")
                        .doc(snapshot.data!.docs[index].get('orderBy'))
                        .collection("adminOrdersCart")
                        .where("shortInfo", whereIn: snapshot.data!.docs[index].get(EcommerceApp.productID))
                        .get(),
                        builder: (_, snap) {
                          return snap.hasData 
                          ? OrderCard(
                            itemCount: snap.data!.docs.length,
                            snapshotData: snap.data!.docs,
                            //
                            orderID: snapshot.data!.docs[index].reference.id,
                            orderBy: snapshot.data!.docs[index].get('orderBy'),
                            addressID: snapshot.data!.docs[index].get('addressID'),
                            //
                            dateCom: snapshot.data!.docs[index].get('orderTime'),
                            nomPropre: snapshot.data!.docs[index].get('proprietaire'),
                          )
                          : Center(child: CircularProgressIndicator(color: Colors.green,));
                        }
                      );
                    })
                : Center(child: emptyOrderUser());
          }),
    );
  }
}

