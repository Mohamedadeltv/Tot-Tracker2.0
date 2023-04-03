import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MYB_2 extends StatelessWidget {
  final String text;
  final Color text_color;
  //final Color background_color;
  final Function()? ontap;
  MYB_2(
      { //required this.background_color,
      required this.text,
      this.ontap,
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
              color: Color.fromARGB(255, 158, 171, 181)),
          // color: Colors.red,
          child: Text(
            text,
            textAlign: TextAlign.center,
            // textWidthBasis: TextWidthBasis.longestLine,
            // textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Silom',
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [Color(0xff9a3a51), Color(0xff1c69a2)],
                ).createShader(Rect.fromLTWH(200.0, 100.0, 200.0, 100.0)),
            ),
          ),
        ));
  }
}
