import 'package:flutter/material.dart';

class ShortCard extends StatelessWidget {
  final Color? colorShortCard;
  final String? countShort;
  final IconData? iconShortCard;
  final String? nameShortCard;

  const ShortCard(
      {this.colorShortCard,
      this.countShort,
      this.iconShortCard,
      this.nameShortCard,});

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
                countShort!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24.0,
                   fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                iconShortCard,
                color: Colors.black54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                nameShortCard!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24.0,
                   fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
