import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel{
  String? name;
  String? phoneNumber;
  String? flatNumber;
  String? city;
  String? quartier;

   AddressModel({
     this.name,
     this.phoneNumber,
     this.flatNumber,
     this.city,
     this.quartier,
    });
    
  factory AddressModel.fromDocument(DocumentSnapshot doc) {
   return AddressModel(
    name: doc.get('name'),
    phoneNumber: doc.get('phoneNumber'),
    flatNumber: doc.get('flatNumber'),
    city: doc.get('city'),
    quartier: doc.get('quartier'),
   );
  }
   

}