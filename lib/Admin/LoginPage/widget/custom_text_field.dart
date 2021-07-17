
import 'package:flutter/material.dart';
import 'package:web_firebase/Widgets/colors.dart';

class CustomTextField extends StatelessWidget {
  
  final TextEditingController? controller;
  final IconData? data;
  final Color? textColor;
  final String? hintText;
  final Color? hintColor;
  final Color? fillColor;
  final TextInputType? textInputType;
  bool? isObsecure = true;

  CustomTextField({
      this.controller,
      this.data,
      this.textColor,
      this.hintColor,
      this.hintText,
      this.fillColor,
      this.isObsecure, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: TextFormField(
        keyboardType:  textInputType,
        style: TextStyle(
          color: textColor,
        ),
        controller: controller,
        obscureText: isObsecure!,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: hintColor, fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(16.0),
          prefixIcon: Container(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: AppColors.SHADOW_RED1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Icon(data, color: AppColors.WHITE),
          ),
        ),
      ),
    );
  }
}
