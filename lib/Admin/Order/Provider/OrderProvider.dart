import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider() {
    initAdminOrder();
  }

  //
  Stream<QuerySnapshot> initAdminOrder() async* {
    yield* FirebaseFirestore.instance.collection("adminOrders").snapshots();
  }

  //get order by id
  Future<DocumentSnapshot> getOrderByID(orderID) async {
    return await FirebaseFirestore.instance
        .collection("adminOrders")
        .doc(orderID)
        .get();
  }
}
