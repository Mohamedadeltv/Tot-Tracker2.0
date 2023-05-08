import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/bracelet_screen.dart';
import '../NEW_WIDGETS/button.dart';
import 'braceletlist.dart';

class ArrowWidget extends StatefulWidget {
  final GlobalKey<_ArrowWidgetState> arrowKey = GlobalKey<_ArrowWidgetState>();

  @override
  _ArrowWidgetState createState() => _ArrowWidgetState();
}

class _ArrowWidgetState extends State<ArrowWidget> {
  bool _showNewWidget = false;

  void _toggleNewWidget() {
    setState(() {
      _showNewWidget = !_showNewWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/drawables/tottracker4.png'),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MYB(
                    text: _showNewWidget ? 'Cancel' : 'Add Bracelet',
                    ontap: _toggleNewWidget,
                    text_color: Color.fromARGB(255, 210, 210, 205),
                    size: 200.0,
                  ),
                ],
              ),
            ),
            if (_showNewWidget) // Only show this widget if _showNewWidget is true
              SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: BraceletForm(
                    _toggleNewWidget,
                  )),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: [
                      Color(0xff9a3a51),
                      Color(0xff1c69a2),
                    ],
                    center: Alignment.center,
                    startAngle: 0.0,
                    endAngle: 2 * 3.14,
                  ),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 109, 82, 82),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: SizedBox(
                  height: _showNewWidget ? 270 : 400,
                  width: double.infinity,
                  child: BraceletsList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
