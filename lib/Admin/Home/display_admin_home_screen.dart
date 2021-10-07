import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Home/widget/short_card.dart';
import 'package:web_firebase/Provider/count_product.dart';
import 'package:web_firebase/Widgets/colors.dart';

class DisplayAdminHomeScreen extends StatefulWidget {
  final Function()? takeImageFunction;
  const DisplayAdminHomeScreen({this.takeImageFunction});
  @override
  _DisplayAdminHomeScreenState createState() => _DisplayAdminHomeScreenState();
}

class _DisplayAdminHomeScreenState extends State<DisplayAdminHomeScreen> {
  Timer? time;

  @override
  void initState() {
    super.initState();
    Provider.of<CountProd>(context, listen: false).countDocumentsProd();
    Provider.of<CountProd>(context, listen: false).countDocumentsAdminOrder();
    Provider.of<CountProd>(context, listen: false).countDocumentsClient();
    time = Timer.periodic(Duration(seconds: 10), (Timer t) =>  autoRefreshData());
  }

  
@override
void dispose() {
  time?.cancel();
  super.dispose();
}

  autoRefreshData() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<CountProd>(context, listen: false).countDocumentsProd();
      Provider.of<CountProd>(context, listen: false).countDocumentsAdminOrder();
      Provider.of<CountProd>(context, listen: false).countDocumentsClient();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Consumer<CountProd>(
                      builder: (context, state, _) {
                        return MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/orderPage');
                          },
                          child: ShortCard(
                            colorShortCard: Colors.blue.withOpacity(0.9),
                            colorShadow: Colors.blue,
                            countShort: state.countAdminOrders.toString(),
                            iconShortCard: Icons.reorder,
                            nameShortCard: state.countAdminOrders == 0 
                                ? "Commande"
                                : "Commandes",
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/clientPage');
                      },
                      child: Consumer<CountProd>(
                        builder: (context, state, _) {
                          return ShortCard(
                            colorShortCard: Colors.orange.withOpacity(0.9),
                            colorShadow: Colors.orange,
                            countShort: state.countClient.toString(),
                            iconShortCard: Icons.person_pin_sharp,
                            nameShortCard:
                                state.countClient == 0 ? "Client" : "Clients",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/addProductPage');
                      },
                      child: ShortCard(
                        colorShortCard: Colors.green.withOpacity(0.9),
                        colorShadow: Colors.green,
                        countShort: "",
                        iconShortCard: Icons.add,
                        nameShortCard: "Ajouter nouveau produit",
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Consumer<CountProd>(
                      builder: (context, state, _) {
                        return MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/productPage');
                          },
                          child: ShortCard(
                            colorShortCard:
                                AppColors.SHADOW_RED1.withOpacity(0.9),
                            colorShadow: AppColors.SHADOW_RED1,
                            countShort: state.countProd.toString(),
                            iconShortCard: Icons.archive,
                            nameShortCard: "Voir, supprimer, modifier produit",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
