import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  String? title;
  String? shortInfo;
  int? price;
  int? quantity;
  String? thumbnailUrl;
  String? reduction;

  CartModel(
      {this.title,
      this.shortInfo,
      this.price,
      this.quantity,
      this.thumbnailUrl,
      this.reduction});


  factory CartModel.fromDocument(DocumentSnapshot doc) {
    return CartModel(
     title: doc.get('title'),
     shortInfo: doc.get('shortInfo'),
     price: doc.get('price'),
     quantity: doc.get('quantity'),
     thumbnailUrl: doc.get('thumbnailUrl'),
     reduction: doc.get('reduction'),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    this.quantity == null || this.quantity == 0
        ? data['quantity'] = 1
        : data['quantity'] = this.quantity;
    data['quantity'] = this.quantity;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['reduction'] = this.reduction;
    return data;
  }
}
