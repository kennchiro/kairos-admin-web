import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Client/widget/tile_user.dart';
import 'package:web_firebase/my_scaffold.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) { 
    return MyScaffold(
        route: '/clientPage',
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (_, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      return TileUser(
                        emailUser: snapshot.data!.docs[index].get('email'),
                        imageUrl: snapshot.data!.docs[index].get('url'),
                        uidUser: snapshot.data!.docs[index].get('uid'),
                        userName: snapshot.data!.docs[index].get('name'),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator(color: Colors.green,));
          },
        ));
  }
}
