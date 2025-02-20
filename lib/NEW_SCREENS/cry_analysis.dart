import 'dart:convert';
import 'package:flutter/material.dart';
import '../api/sound_recorder.dart';
import '../sleep_screen/const.dart';
import '../sleep_screen/custom_clipper.dart';
import 'package:tottracker/api/audio_player.dart';

import '1.dart';

class CryingAnalyzerApp extends StatefulWidget {
  final SoundRecorder soundRecorderr;

  const CryingAnalyzerApp({super.key, required this.soundRecorderr});
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
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _showCryingReasons = true;
      });
    });
  }

  void handleLikeButtonPressed() {
    setState(() {
      _helpful = true;
    });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BeginningScreen()),
  );
  }

  void handleDislikeButtonPressed() {
    setState(() {
      _helpful = false;
    });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BeginningScreen()),
  );
  }
void _showBottomSheet(BuildContext context) {
    
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.child_care,
                size: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 16.0),
              Text(
                'Place your baby\'s hand on the device.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
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
String? highestReason;

    if (_showCryingReasons) {
      String classProbabilitiesString = widget.soundRecorderr.classProbabilitiesString.replaceAll(' ', '');
      List<String> probabilities = classProbabilitiesString.split(',');

      Map<String, double> cryingReasons = {
        'Burping': double.parse(probabilities[0]),
        'Discomfort': double.parse(probabilities[1]),
        'Hungry': double.parse(probabilities[2]),
        'Pain': double.parse(probabilities[3]),
        'Tired': double.parse(probabilities[4]),
      };

      double highestValue = double.negativeInfinity;

      cryingReasons.forEach((reason, value) {
        if (value > highestValue) {
          highestValue = value;
          highestReason = reason;
        }
      });
    }
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
                          "Sound",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Analyzing",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
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
                      child: GestureDetector(
                        onTap: handleImagePressed,
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(
                            image:
                                AssetImage('assets/drawables/tottracker4.png'),
                            height: 200,
                            width: 200,
                            color: Colors.white.withOpacity(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            _showCryingReasons
                ? Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CryingReasonsWidget(soundRecorder: widget.soundRecorderr,),
                          SizedBox(height: 20.0),

                            Container(alignment: Alignment.center,
                              child: Text(
                              'The reason why the baby is crying is...... ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                            ),
                          Container(alignment: Alignment.center,
                            child: Text(
                              '${highestReason ?? 'No highest reason found'}',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Color.fromARGB(255, 33, 58, 243),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),


                          
                          SizedBox(height: 30.0),
                          Container(alignment: Alignment.center,
                            child: Text(
                              'Was this Helpful?',
                              style: TextStyle(
                                
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [SizedBox(height: 15.0,),
                              ElevatedButton(
                                onPressed: handleLikeButtonPressed,
                                child: Text('Yes'),
                              ),
                              SizedBox(width: 10.0),
                              ElevatedButton(
                                onPressed: handleDislikeButtonPressed,
                                child: Text('No'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          
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
  final SoundRecorder soundRecorder;

  const CryingReasonsWidget({super.key, required this.soundRecorder});
  @override
  Widget build(BuildContext context) {
    String classProbabilitiesString = soundRecorder.classProbabilitiesString.replaceAll(' ', '');

     List<String> probabilities = classProbabilitiesString.split(',');

    Map<String, double> cryingReasons = {
      'Burping': double.parse(probabilities[0]),
      'Discomfort': double.parse(probabilities[1]),
      'Hungry': double.parse(probabilities[2]),
      'Pain': double.parse(probabilities[3]),
      'Tired': double.parse(probabilities[4]),
    };
String? highestReason;
double highestValue = double.negativeInfinity;

cryingReasons.forEach((reason, value) {
  if (value > highestValue) {
    highestValue = value;
    highestReason = reason;
  }
});

if (highestReason != null) {
  print('Highest reason: $highestReason');
} else {
  print('No highest reason found');
}


    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(2),
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
                      value: entry.value/100.0,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Text('${(entry.value)}%'),
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
