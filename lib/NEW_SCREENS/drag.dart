import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/bracelet_screen.dart';
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
      appBar: AppBar(
        title: Text('Bracelet List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Bracelet List',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: _toggleNewWidget,
                        child: Text(
                            _showNewWidget ? 'Cancel' : 'Add a new Bracelet'))
                  ],
                ),
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
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
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
