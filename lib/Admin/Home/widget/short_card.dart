import 'package:flutter/material.dart';

class ShortCard extends StatelessWidget {

  final Color colorShortCard;
  final String countShort;
  final IconData iconShortCard;
  final String nameShortCard;
  final Color colorShadow;
  final Color miniCardColor;
  bool showMiniCard = false;

   ShortCard({
    Key? key,
    required this.colorShortCard,
    required this.countShort,
    required this.iconShortCard,
    required this.nameShortCard,
    required this.colorShadow,
    required this.miniCardColor,
    required this.showMiniCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 190,
        color: colorShortCard,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 if(this.showMiniCard)
                  Material(
                    color: this.miniCardColor,
                    elevation: 5.0,
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        this.countShort,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    iconShortCard,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  nameShortCard,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
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
                      Text(
                        'Voir plus',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.forward,
                        color: Colors.white,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
