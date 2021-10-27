import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_firebase/Admin/Client/client_page.dart';
import 'package:web_firebase/Admin/Crud/crud_page_.dart';
import 'package:web_firebase/Admin/Home/admin_upload_items.dart';
import 'package:web_firebase/Admin/Home/home_page.dart';
import 'package:web_firebase/Admin/LoginPage/Admin_SignIn_Screen.dart';
import 'package:web_firebase/Admin/Order/order_details_page.dart';
import 'package:web_firebase/Admin/Order/order_page.dart';
import 'package:web_firebase/Config/config.dart';
import 'package:web_firebase/Provider/count_product.dart';
import 'package:web_firebase/Widgets/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EcommerceApp.firestore = FirebaseFirestore.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.blue,
 ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CountProd()),
      ],
      child: MaterialApp(
        title: 'Admin Kairos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginAdminPage(title: 'Kairos'),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final page = _getPageWidget(settings);
          if (page != null) {
            return PageRouteBuilder(
                settings: settings,
                pageBuilder: (_, __, ___) => page,
                transitionsBuilder: (_, anim, __, child) {
                  return FadeTransition(
                    opacity: anim,
                    child: child,
                  );
                });
          }
          return null;
        },
      ),
    );
  }

  Widget? _getPageWidget(RouteSettings settings) {
    if (settings.name == null) {
      return null;
    }
    final uri = Uri.parse(settings.name!);
    switch (uri.path) {
      case '/':
        return AdminSignInScreen();
      case '/homePage':
        return HomePage();
      case '/clientPage':
        return ClientPage();
      case '/orderPage':
        return OrderPage();
      case '/orderDetailPage':
        return OrderDetailPage();
      case '/productPage':
        return CrudPage();
      case '/addProductPage':
        return UploadItems();
    }
    return null;
  }
}

class LoginAdminPage extends StatefulWidget {
  LoginAdminPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.SHADOW_RED1,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}
