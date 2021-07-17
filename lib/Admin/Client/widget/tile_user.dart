import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Client/client_activity.dart';
import 'package:web_firebase/Widgets/colors.dart';

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
    return Container(
        decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: AppColors.SHADOW,
        ),
        width: MediaQuery.of(context).size.width /2,
        height: 116,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 50,
        height: 50,
        child: CircleAvatar(
          minRadius: 30,
          backgroundImage: NetworkImage(this.imageUrl),
        ),
      ),
       SizedBox(
              width: 10,
        ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.userName,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.mail, color: Colors.grey, size: 20),
                 SizedBox(
                   width: 5,
                 ),
                Text(
                  this.emailUser,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                     Route route = MaterialPageRoute(builder: (c) =>  ClientActivity(
                      name: this.userName,
                      uid: this.uidUser,
                    ));
                    Navigator.push(context, route);
                  },
                  child: Text("Voir ses activites"),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye_outlined,
                      color: Colors.green, size: 20),
                )
              ],
            )
          ],
        ),
      )
    ],
        ),
      );
  }
}
