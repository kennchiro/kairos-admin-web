
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Home/display_admin_home_screen.dart';
import 'package:web_firebase/my_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeUploadPageState createState() => _HomeUploadPageState();
}

class _HomeUploadPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
    route: '/homePage', 
    body: DisplayAdminHomeScreen()
    );
  }
}
