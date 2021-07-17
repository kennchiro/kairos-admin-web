
import 'package:flutter/material.dart';
import 'package:web_firebase/Widgets/colors.dart';

class AlertDelete extends StatelessWidget {

  final Function()? onDelete;
  final String? name;
  const AlertDelete({ this.onDelete, this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Do you want to delete ${this.name} ?',
        style: TextStyle(color: AppColors.DARK, fontSize: 13),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red,),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "No",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.GREEN)),
          onPressed: onDelete,
          child: Text("Yes", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
