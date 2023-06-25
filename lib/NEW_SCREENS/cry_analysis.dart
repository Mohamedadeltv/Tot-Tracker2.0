import 'package:flutter/material.dart';

import '../sleep_screen/const.dart';
import '../sleep_screen/custom_clipper.dart';
import 'package:tottracker/api/audio_player.dart';
class CryingAnalyzerApp extends StatefulWidget {
  @override
  _CryingAnalyzerAppState createState() => _CryingAnalyzerAppState();
}

class _CryingAnalyzerAppState extends State<CryingAnalyzerApp> {
  bool _showCryingReasons = false;
  bool _helpful = false;

  void handleImagePressed() {
    Navigator.pop(context); // Navigate back to a specific widget
  }
  @override
  void initState() {
    super.initState();

    // After 4 seconds, update the state to show the CryingReasonsWidget
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showCryingReasons = true;
      });
    });
  }

  void handleLikeButtonPressed() {
    setState(() {
      _helpful = true;
    });
  }

  void handleDislikeButtonPressed() {
    setState(() {
      _helpful = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                       Stack(children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightBlue,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Status",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Sleeping",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Constants.darkBlue),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: Container(
              height: 120,
              width: 120,
              child:GestureDetector(
                    onTap: handleImagePressed,
                    child: Container(
                      height: 120,
                      width: 120,
                      child: Image(
                        image: AssetImage('assets/drawables/tottracker4.png'),
                        height: 200,
                        width: 200,
                        color: Colors.white.withOpacity(1),
                      ),
                    ),
                  ),),
          ),
        ]),
              ],
            ),
            _showCryingReasons
                ? Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CryingReasonsWidget(),
                          SizedBox(height: 20.0),
                          Text(
                            'Was that helpful?',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: handleLikeButtonPressed,
                                child: Text('Like'),
                              ),
                              SizedBox(width: 10.0),
                              ElevatedButton(
                                onPressed: handleDislikeButtonPressed,
                                child: Text('Dislike'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            _helpful ? 'Thank you for your feedback!' : 'We appreciate your feedback.',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
class CryingReasonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your own crying reasons map
    Map<String, double> cryingReasons = {
      'Hunger': 0.4,
      'Pain': 0.3,
      'Sleepiness': 0.2,
      'Discomfort': 0.1,
    };

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color:Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: cryingReasons.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: LinearProgressIndicator(
                      value: entry.value,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('${(entry.value * 100).toInt()}%'),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
