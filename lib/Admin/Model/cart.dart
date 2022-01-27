import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  String title;
  String shortInfo;
  int price;
  int quantity;
  String thumbnailUrl;
  String reduction;

  CartModel({
    required this.title,
    required this.shortInfo,
    required this.price,
    required this.quantity,
    required this.thumbnailUrl,
    required this.reduction
  });


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
  
   factory CartModel.fromJson(Map<dynamic, dynamic> json) {
    return CartModel(
      title: json['title'],
      shortInfo: json['shortInfo'],
      price: json['price'],
      quantity: json['quantity'],
      thumbnailUrl: json['thumbnailUrl'],
      reduction: json['reduction'],
    );
  }

}
