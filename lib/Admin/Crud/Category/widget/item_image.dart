import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final double? padding;

  ItemImage({
    this.image,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return this.image == null 
    ? SizedBox.shrink()
    : Padding(
      padding: EdgeInsets.all(this.padding ?? 0),
      child: Image.network(
        this.image!,
        height: this.height,
        width: this.width,
        fit: BoxFit.contain,
      )
    );

  }
}
