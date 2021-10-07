import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_firebase/Widgets/colors.dart';

class DetailPaiement extends StatelessWidget {
  final String orderTime;
  final String expediteur;
  final String reference;
  
  const DetailPaiement({
    Key? key,
    required this.orderTime,
    required this.expediteur,
    required this.reference,
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.LIGHT_GREEN,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date de commande : ' +
                DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                    DateTime.fromMillisecondsSinceEpoch(int.parse(orderTime))),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSansCondensed',
            ),
          ),
          Text(
            'Expéditeur (Mobile Money) : ' + expediteur,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSansCondensed',
            ),
          ),
          Text(
            'Numero de reference : ' + reference,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSansCondensed',
            ),
          ),
        ],
      ),
    );
  }
}
