import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Client/client_page.dart';
import 'package:web_firebase/Widgets/colors.dart';

class ClientStatusBanner extends StatelessWidget {
  final bool status;

  const ClientStatusBanner({
    Key? key,
    required this.status,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message;
    IconData iconData;


    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? message = 'succès' : message = 'Unsuccessful';

    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Container(
            height: 50,
            width: 100,
            color: AppColors.SHADOW_RED1,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Route route;
                      route = MaterialPageRoute(
                        builder: (_) => ClientPage(),
                      );
                      Navigator.pushReplacement(context, route);
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
                Text(
                  'retour',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          //
          Center(
            child: Row(
              children: [
                Text(
                  'Commande a été passée avec $message',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColors.WHITE,
                    child: Center(
                      child: Icon(
                        iconData,
                        color: AppColors.GREEN,
                        size: 14,
                      ),
                    )),
              ],
            ),
          ),

          Text(''),
        ],
      ),
    );
  }
}