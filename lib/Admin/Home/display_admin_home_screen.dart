import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_firebase/Admin/Client/client_page.dart';
import 'package:web_firebase/Admin/Crud/crud_page_.dart';
import 'package:web_firebase/Admin/Home/admin_upload_items.dart';
import 'package:web_firebase/Admin/Home/widget/long_card.dart';
import 'package:web_firebase/Admin/Home/widget/short_card.dart';
import 'package:web_firebase/Admin/Order/order_page.dart';
import 'package:web_firebase/Drawer/my_drawer.dart';
import 'package:web_firebase/Provider/count_product.dart';
import 'package:web_firebase/Widgets/colors.dart';

class DisplayAdminHomeScreen extends StatefulWidget {
  final Function()? takeImageFunction;
  const DisplayAdminHomeScreen({this.takeImageFunction});
  @override
  _DisplayAdminHomeScreenState createState() => _DisplayAdminHomeScreenState();
}

class _DisplayAdminHomeScreenState extends State<DisplayAdminHomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountProd>(context, listen: false).countDocumentsProd();
    Provider.of<CountProd>(context, listen: false).countDocumentsAdminOrder();
    Provider.of<CountProd>(context, listen: false).countDocumentsClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            "Admin",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [AppColors.SHADOW_RED1, AppColors.SHADOW_RED1],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                tooltip: "Déconnexion",
                onPressed: () {},
                icon: Icon(Icons.power_settings_new, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      // drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                            Route route =
                                MaterialPageRoute(builder: (c) => OrderPage());
                            Navigator.pushReplacement(context, route);
                          },
                          child: LongCard(
                            colorLongCard: Colors.white,
                            countLong: state.countAdminOrders.toString(),
                            iconLongCard: Icons.reorder,
                            nameLongCard: state.countAdminOrders == 0 ? "Commande" : "Commandes",
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0),
                    MaterialButton(
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => ClientPage());
                        Navigator.push(context, route);
                      },
                      child: Consumer<CountProd>(
                        builder: (context, state, _) {
                          return ShortCard(
                            colorShortCard: Colors.white,
                            countShort: state.countClient.toString(),
                            iconShortCard: Icons.person_pin_sharp,
                            nameShortCard: state.countClient == 0 ? "Client" : "Clients",
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
                        Route route =
                            MaterialPageRoute(builder: (c) => UploadItems());
                        Navigator.pushReplacement(context, route);
                      },
                      child: ShortCard(
                        colorShortCard: Colors.white,
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
                            Route route =
                                MaterialPageRoute(builder: (c) => CrudPage());
                            Navigator.pushReplacement(context, route);
                          },
                          child: LongCard(
                            colorLongCard: Colors.white,
                            countLong: state.countProd.toString(),
                            iconLongCard: Icons.archive,
                            nameLongCard: "Voir, supprimer, modifier produit",
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
