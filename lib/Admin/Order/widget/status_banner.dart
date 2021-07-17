import 'package:flutter/material.dart';
import 'package:web_firebase/Widgets/colors.dart';

class StatusBanner extends StatelessWidget {

 final bool status;
 StatusBanner({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  String message;
  IconData iconData;

  status ? iconData = Icons.done : iconData = Icons.cancel;
  status ? message = 'Successful' : message = 'Unsuccessful';

    return Container(
      margin: EdgeInsets.only(top: 10),
      color: AppColors.LIGHT_GREEN,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Commande Shipped $message',
            style: TextStyle(
              color: AppColors.WHITE,
            ),
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
                  color: AppColors.LIGHT_GREEN,
                  size: 14,
                ),
              )),
        ],
      ),
    );
  }
}