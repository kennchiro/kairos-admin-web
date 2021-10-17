import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Client/client_activity.dart';

class TileUser extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String emailUser;
  final String uidUser;

  const TileUser({
    Key? key,
    required this.imageUrl,
    required this.userName,
    required this.emailUser,
    required this.uidUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListTile(
          leading: Container(
            height: 50, 
            width: 50, 
            color: Colors.transparent,
            child: CircleAvatar(
              backgroundImage:  NetworkImage(this.imageUrl),
            ),
          ),
          title: Text(this.userName),
          subtitle: Text(this.emailUser),
          trailing: Icon(Icons.remove_red_eye),
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => ClientActivity(
                      name: this.userName,
                      uid: this.uidUser,
                    ));
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
    );
  }
}
