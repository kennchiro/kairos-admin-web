import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Client/client_order.dart';
import 'package:web_firebase/Widgets/colors.dart';

class TileUser extends StatefulWidget {
  final String imageUrl;
  final String userName;
  final String emailUser;
  final String uidUser;
  final int countOrder;

  const TileUser({
    Key? key,
    required this.imageUrl,
    required this.userName,
    required this.emailUser,
    required this.uidUser,
    required this.countOrder,
  }) : super(key: key);

  @override
  _TileUserState createState() => _TileUserState();
}

class _TileUserState extends State<TileUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            height: 170,
            padding: const EdgeInsets.all(6),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  Image.network(
                    this.widget.imageUrl,
                    width: 150,
                    height: 80,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              this.widget.userName,
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (c) => ClientOrder(
                                            uid: this.widget.uidUser,
                                            username: this.widget.userName,
                                            countOrder: this.widget.countOrder,
                                          ));
                                  Navigator.pushReplacement(context, route);
                                },
                                icon: Tooltip(
                                    message: 'Commande',
                                    child: this.widget.countOrder == 0
                                        ? Icon(
                                            Icons.shopping_cart,
                                            color: AppColors.PRIMARY_COLOR,
                                          )
                                        : Badge(
                                            position: BadgePosition.topEnd(),
                                            shape: BadgeShape.circle,
                                            animationDuration: const Duration(
                                                milliseconds: 800),
                                            animationType:
                                                BadgeAnimationType.fade,
                                            badgeColor: Colors.red,
                                            badgeContent: Text(
                                                this
                                                    .widget
                                                    .countOrder
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: AppColors.PRIMARY_COLOR,
                                            ),
                                          )),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Tooltip(
                                  message: 'Activite',
                                  child: Icon(
                                    Icons.library_books,
                                    color: AppColors.PRIMARY_COLOR,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
