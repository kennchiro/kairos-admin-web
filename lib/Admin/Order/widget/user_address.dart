import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:web_firebase/Admin/Model/address.dart';

class UserAddress extends StatelessWidget {
  final AddressModel model;
  final String id;
  const UserAddress({
    Key? key,
    required this.model,
    required this.id,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formateDate = DateFormat('EEE d MMM').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Supplier address
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Text("${model.flatNumber}, ${model.quartier}",
                    style: TextStyle(fontSize: 11)),
                Text("${model.city}", style: TextStyle(fontSize: 11)),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Text("${model.phoneNumber}", style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              children: [
                Text('ID', style: TextStyle(fontSize: 11)),
                Container(
                  height: 50,
                  width: 50,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: id,
                  ),
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text(formateDate + ', Fianarantsoa',
                    style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
        SizedBox(height: 1 * PdfPageFormat.cm),
      ],
    );
  }
}
