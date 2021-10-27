
import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget
{

  linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),),
  );
}

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
         linearProgress(),
          SizedBox(
            height: 10,
          ),
          Text("Veuillez patienter...", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
