import 'package:flutter/material.dart';

class ShortCard extends StatelessWidget {
  final Color colorShortCard;
  final String countShort;
  final IconData iconShortCard;
  final String nameShortCard;
  final Color colorShadow;

  const ShortCard({
    Key? key,
    required this.colorShortCard,
    required this.countShort,
    required this.iconShortCard,
    required this.nameShortCard,
    required this.colorShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 190,
        color: colorShortCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                countShort,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                iconShortCard,
                color: Colors.white,
               size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                nameShortCard,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
           Spacer(),
           Container(
             color: this.colorShadow,
             height: 30,
             width: double.infinity,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text('Voir plus', style: TextStyle(color: Colors.white),),
                 Icon(Icons.forward, color: Colors.white,)
               ],
             )
           ),
          ],
        ),
      ),
    );
  }
}
