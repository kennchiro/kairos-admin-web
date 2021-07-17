import 'package:flutter/material.dart';

class LongCard extends StatelessWidget {
  final Color? colorLongCard;
  final String? countLong;
  final IconData? iconLongCard;
  final String? nameLongCard;

  const LongCard(
      {this.colorLongCard,
      this.countLong,
      this.iconLongCard,
      this.nameLongCard,});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
          child: Container(
        height: 190,
        color: colorLongCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                countLong!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                iconLongCard,
                color: Colors.black54
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                nameLongCard!,
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
