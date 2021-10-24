// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:web_firebase/Admin/Client/widget/tile_user.dart';
// import 'package:web_firebase/Widgets/colors.dart';

// class SearchClient extends StatefulWidget {
//   SearchClient({Key? key}) : super(key: key);

//   @override
//   _SearchClientState createState() => _SearchClientState();
// }

// class _SearchClientState extends State<SearchClient> {
//   Future<QuerySnapshot>? documentList;
//   bool check = false;

//   Future initSearch(String query) async {
//     String? capitalizedValue;
//     if (query.length > 1) {
//       capitalizedValue =
//           query.substring(0, 1).toUpperCase() + query.substring(1);
//     } else if (query.length > 0) {
//       capitalizedValue = query.substring(0, 1).toUpperCase();
//     }

//     documentList = FirebaseFirestore.instance
//         .collection("users")
//         .where("name", isGreaterThanOrEqualTo: capitalizedValue)
//         .get();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.SHADOW_RED1,
//         elevation: 0,
//         title: Center(
//           child: Text(
//             "Rechercher un client",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         actions: [],
//         bottom: PreferredSize(
//           child: Column(
//             children: [
//               searchWidget(),
//             ],
//           ),
//           preferredSize: Size(56, 80),
//         ),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: documentList,
//         builder: (_, snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (_, index) {
//                     return TileUser(
//                       emailUser: snapshot.data!.docs[index].get('email'),
//                       imageUrl: snapshot.data!.docs[index].get('url'),
//                       uidUser: snapshot.data!.docs[index].get('uid'),
//                       userName: snapshot.data!.docs[index].get('name'),
//                     );
//                   },
//                 )
//               : Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }

//   Widget searchWidget() {
//     return Container(
//       alignment: Alignment.center,
//       padding: EdgeInsets.all(10),
//       height: 80.0,
//       color: AppColors.WHITE,
//       child: Container(
//         width: 400,
//         height: 50.0,
//         decoration: BoxDecoration(
//           color: AppColors.SHADOW,
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Row(
//           children: [
//             Flexible(
//               child: Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: TextField(
//                     textAlign: TextAlign.start,
//                     onChanged: (val) {
//                       initSearch(val);
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Recherche...',
//                       hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
//                       suffixIcon: Material(
//                         elevation: 2.0,
//                         borderRadius: BorderRadius.all(Radius.circular(30)),
//                         child: Icon(Icons.search, color: Colors.grey),
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
