import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:web_firebase/Admin/Model/address.dart';

class ClientShippingDetails extends StatefulWidget {
  final AddressModel model;
  final String userUID;

  const ClientShippingDetails({
    Key? key,
    required this.model,
    required this.userUID,
  }) : super(key: key);

  @override
  _ClientShippingDetailsState createState() => _ClientShippingDetailsState();
}

class _ClientShippingDetailsState extends State<ClientShippingDetails> {
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
                Text(widget.model.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Text("${widget.model.flatNumber}, ${widget.model.quartier}",
                    style: TextStyle(fontSize: 11)),
                Text("${widget.model.city}", style: TextStyle(fontSize: 11)),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Text("${widget.model.phoneNumber}",
                    style: TextStyle(fontSize: 11)),
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
                    data: this.widget.userUID,
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
