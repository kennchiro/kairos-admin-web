import 'package:flutter/material.dart';
import 'package:web_firebase/my_scaffold.dart';

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
    return MyScaffold(
      route: '',
      body:  Center(
          child: Text(
            this.widget.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
    );
  }
}
