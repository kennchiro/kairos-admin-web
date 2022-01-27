import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Client/Provider/ClientProvider.dart';
import 'package:web_firebase/Admin/Client/widget/client_bar_lateral.dart';
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClientBarLateral(),
              //list client
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Provider.of<ClientProvider>(context, listen: false)
                      .initUser(),
                  builder: (_, snapshot) {
                    return LayoutBuilder(builder: (context, constraint) {
                      return snapshot.hasData
                          ? GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: constraint.maxWidth < 768 ? 2 : 6,
                              children: List.generate(
                                  snapshot.data!.docs.length, (index) {
                                return StreamBuilder<QuerySnapshot>(
                                    stream: Provider.of<ClientProvider>(context,
                                            listen: false)
                                        .getOrdersUsers(snapshot.data!.docs[index].get('uid')),
                                    builder: (_, snaps) {
                                      return TileUser(
                                        imageUrl: snapshot.data!.docs[index]
                                            .get('url'),
                                        userName: snapshot.data!.docs[index]
                                            .get('name'),
                                        emailUser: snapshot.data!.docs[index]
                                            .get('email'),
                                        uidUser: snapshot.data!.docs[index]
                                            .get('uid'),
                                        countOrder: snaps.data!.docs.length,
                                      );
                                    });
                              }),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: Colors.green,
                            ));
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
