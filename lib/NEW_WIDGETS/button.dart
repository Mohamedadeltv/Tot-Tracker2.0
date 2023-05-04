import 'package:flutter/material.dart';

class MYB extends StatelessWidget {
  final String text;
  final Color text_color;
  //final Color background_color;
  final Function() ontap;
  MYB(
      { //required this.background_color,
      required this.text,
      required this.ontap,
      required this.text_color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(16),
        // margin: EdgeInsets.all(10),
        height: 57,
        width: 157,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient:
                LinearGradient(colors: [Color(0xff9a3a51), Color(0xff1c69a2)])),
        // color: Colors.red,
        child: Text(
          text,
          textAlign: TextAlign.center,
          // textWidthBasis: TextWidthBasis.longestLine,
          // textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: text_color,
              fontFamily: 'Silom',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
