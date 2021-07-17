import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EcommerceApp {
  static FirebaseFirestore? firestore;
  static SharedPreferences? sharedPreferences;

  static final String productID = 'productIDs';
}