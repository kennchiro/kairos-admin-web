import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Provider/count_product.dart';
import 'package:web_firebase/Widgets/colors.dart';

class OrderBarLateral extends StatelessWidget {
  const OrderBarLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 100,
            color: AppColors.SHADOW_RED1,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/homePage');
                    },
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    )),
                Text(
                  'Accueil',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Center(
            child: Text('Nos commandes', style: TextStyle(color: Colors.white)),
          ),
          Center(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Consumer<CountProd>(
                    builder: (context, state, _) {
                      return state.countAdminOrders == 0 
                      ? Icon(Icons.reorder, color: Colors.white)
                      : Badge(
                        position: BadgePosition.topEnd(),
                        shape: BadgeShape.circle,
                        animationDuration: const Duration(milliseconds: 800),
                        animationType: BadgeAnimationType.fade,
                        badgeColor: Colors.red,
                        badgeContent: Text(state.countAdminOrders.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        child: Icon(Icons.reorder, color: Colors.white),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
