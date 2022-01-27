import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CountProd with ChangeNotifier, DiagnosticableTreeMixin {
  CountProd() {
    countDocumentsAdminOrder();
    countDocumentsProd();
    countDocumentsClient();
  }
  
  // Product
  int _countProd = 0;
  int get countProd => _countProd;
  Future<void> countDocumentsProd() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection("Items").get();
    List<DocumentSnapshot> _docSnap = _myDoc.docs;
    _countProd = _docSnap.length;
    await Future.delayed(const Duration(microseconds: 100), () {
      notifyListeners();
    });
  }

  //Admin Orders
  int _countAdminOrders = 0;
  int get countAdminOrders => _countAdminOrders;
  Future<void> countDocumentsAdminOrder() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection("adminOrders").get();
    List<DocumentSnapshot> _docSnap = _myDoc.docs;
    _countAdminOrders = _docSnap.length;
    notifyListeners();
  }

  //count client
  int _countClient = 0;
  int get countClient => _countClient;
  Future<void> countDocumentsClient() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection("users").get();
    List<DocumentSnapshot> _docSnap = _myDoc.docs;
    _countClient = _docSnap.length;
    await Future.delayed(const Duration(microseconds: 100), () {
      notifyListeners();
    });
  }
}
