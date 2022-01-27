import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';

class ClientProvider extends ChangeNotifier {
  ClientProvider() {
    initUser();
  }

  // init user data
  Stream<QuerySnapshot> initUser() async* {
    yield* FirebaseFirestore.instance.collection("users").snapshots();
  }

  // all orders of all user
  Stream<QuerySnapshot> getOrdersUsers(ordersID) async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(ordersID)
        .collection('orders')
        .snapshots();
  }

  // get order of user by id
  Stream<QuerySnapshot> getOrderUserByID(uid) async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .snapshots();
  }

  // get order and user by their id
  Future<DocumentSnapshot> getOrderAndUserByID(userUID, orderID) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('orders')
        .doc(orderID)
        .get();
  }

  // get address by id
  Future<DocumentSnapshot> getAddressByID(userUID, addressID) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('userAddress')
        .doc(addressID)
        .get();
  }

  //
  confirmeParcelShifted(context, orderID, userUID) {
    // supprimer commande d'admin/orderID
    FirebaseFirestore.instance.collection("adminOrders").doc(orderID).delete();

    //supprimer la commande du client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUID)
        .collection("orders")
        .doc(orderID)
        .delete();

    //envoyer la facture/message vers le client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUID)
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

  //annuler la commande
  cancelOrder(context, orderID, userUID, motifText) {
     // supprimer commande d'admin/orderID
    FirebaseFirestore.instance.collection("adminOrders").doc(orderID).delete();

   //supprimer la commande du client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUID)
        .collection("orders")
        .doc(orderID)
        .delete();

    //envoyer la facture/message vers le client/id
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUID)
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

}
