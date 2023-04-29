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
            SizedBox(height: 20),
            if (_showNewWidget) // Only show this widget if _showNewWidget is true
              SizedBox(
                  height: 270, width: double.infinity, child: BraceletForm()),
            Text(
              'Bracelet List',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
                height: 270, width: double.infinity, child: BraceletsList()),
          ],
        ),
      ),
    );
  }
}
