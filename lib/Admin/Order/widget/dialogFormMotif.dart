
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DialogFormMotif extends StatefulWidget {
  final TextEditingController motifController;
  final Function okFormMotif;
  
  const DialogFormMotif({
    Key? key,
    required this.motifController,
    required this.okFormMotif,
  }) : super(key: key);


  @override
  _DialogFormMotifState createState() => _DialogFormMotifState();
}

class _DialogFormMotifState extends State<DialogFormMotif> {
  void _showFormDialog() {
    var alert = AlertDialog(
      clipBehavior: Clip.hardEdge,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              keyboardAppearance: Brightness.dark,
              controller: this.widget.motifController,
              obscureText: false,
              autofocus: true,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: "Motifs d'annulation",
              ),
            ),
          ),
        ],
      ),
      actions: [
        //FormMotif
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            if (this.widget.motifController.text.isNotEmpty) {
              this.widget.okFormMotif();
              this.widget.motifController.clear();
            } else {
              EasyLoading.showInfo(
                "Veuillez saisir votre motif d'annulation de la commande",
              );
            }
          },
          child: Text('Valider', style: TextStyle(color: Colors.white)),
        ),

        //cancel
        TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                this.widget.motifController.clear();
              });
            },
            child: Text('Annuler', style: TextStyle(color: Colors.white, fontSize: 10))),
      ],
    );

    //
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: ()=> _showFormDialog(),
      child: Text(
        'Annuler commande',
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      color: Colors.red,
    );
  }
}
