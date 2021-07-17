import 'package:flutter/material.dart';

import 'package:web_firebase/Widgets/colors.dart';

class ClientActivity extends StatefulWidget {
  final String name;
  final String uid;

  ClientActivity({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  _ClientActivityState createState() => _ClientActivityState();
}

class _ClientActivityState extends State<ClientActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.SHADOW_RED1,
        elevation: 0,
        title: Center(
          child: Text(
            this.widget.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [],
      ),
    );
  }
}
