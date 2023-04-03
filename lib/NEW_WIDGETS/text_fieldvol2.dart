import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mytextfieldvol2 extends StatelessWidget {
  final IconData icon;
  final String hinttext;
  final Color color1;
  const mytextfieldvol2(
      {required this.hinttext, required this.icon, required this.color1});

  @override
  Widget build(BuildContext context) {
    return Padding(
  padding: const EdgeInsets.all(9.0),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromARGB(255, 212, 207, 207),
    ),
    child: TextFormField(
      cursorColor: color1,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: color1,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
        hintText: hinttext,
      ),
    ),
  ),
);

  }
}
