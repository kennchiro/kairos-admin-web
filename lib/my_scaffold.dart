import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_firebase/Widgets/colors.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    Key? key,
    required this.route,
    required this.body,
  }) : super(key: key);

  final Widget body;
  final String route;

  final List<MenuItem> _sideBarItems = const [
    MenuItem(
      title: 'Accueil',
      route: '/homePage',
      icon: Icons.home,
    ),
    MenuItem(
      title: 'Client',
      route: '/clientPage',
      icon: Icons.person,
    ),
    MenuItem(
      title: 'Commande',
      route: '/orderPage',
      icon: Icons.reorder,
    ),
    MenuItem(
      title: 'Produit',
      route: '/productPage',
      icon: Icons.archive,
    ),
    MenuItem(
      title: 'Ajout nouveau produit',
      route: '/addProductPage',
      icon: Icons.add,
    ),
  ];

  final List<MenuItem> _adminMenuItems = const [
    MenuItem(
      title: 'Logout',
      icon: Icons.logout,
      route: '/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.SHADOW_RED1,
        title: const Text('Admin Kairos'),
        actions: [
          PopupMenuButton<MenuItem>(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.account_circle),
            ),
            itemBuilder: (context) {
              return _adminMenuItems.map((MenuItem item) {
                return PopupMenuItem<MenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(item.icon, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
            onSelected: (item) {
              print(
                  'actions: onSelected(): title = ${item.title}, route = ${item.route}');
              Navigator.of(context).pushNamed(item.route!);
            },
          ),
        ],
      ),
      sideBar: SideBar(
        backgroundColor: Color(0xff444444),
        activeBackgroundColor: Colors.black26,
        borderColor: Color(0xff444444),
        iconColor: Colors.white,
        activeIconColor: AppColors.SHADOW_RED1,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        activeTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        items: _sideBarItems,
        selectedRoute: route,
        onSelected: (item) {
          print(
              'sideBar: onTap(): title = ${item.title}, route = ${item.route}');
          if (item.route != null && item.route != route) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 160,
          decoration: BoxDecoration(
             color: Color(0xff444444),
            image: DecorationImage(
              colorFilter: ColorFilter.srgbToLinearGamma(),
              image: AssetImage(
                "images/admin.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: AppColors.SHADOW_RED1,
          child: Center(
            child: Text(
              DateTime.now().toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: body,
      ),
    );
  }
}
