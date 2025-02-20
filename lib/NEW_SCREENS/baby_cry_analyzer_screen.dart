import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/sky.dart';
import 'package:tottracker/api/sound_recorder.dart';
import 'package:tottracker/widgets/timer.dart';
import '../sleep_screen/const.dart';
import '../sleep_screen/custom_clipper.dart';
import 'cry_analysis.dart';

class BabyCryAnalyzerScreen extends StatefulWidget {
  @override
  _BabyCryAnalyzerScreenState createState() => _BabyCryAnalyzerScreenState();
}

class _BabyCryAnalyzerScreenState extends State<BabyCryAnalyzerScreen> {
  final timerController = TimerController();
  final recorder = SoundRecorder();

  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightBlue,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
              left: 20,
              top: 80,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(
                      text: 'Tot',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    TextSpan(
                      text: 'Tracker',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              )),
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
            right: 20,
            top: 50,
            child: Container(
                height: 120,
                width: 120,
                child: Image(
                  image: AssetImage('assets/drawables/tottracker4.png'),
                  height: 200,
                  width: 200,
                  color: Colors.white,
                )),
          ),
          buildStart(),
        ],
      ),
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    late IconData icon = isRecording ? Icons.stop : Icons.mic;
    late Color primary = isRecording ? Colors.red : Colors.white;
    late Color onPrimary = isRecording ? Colors.white : Colors.black;

    return Center(
      child: Column(
        children: [
          SizedBox(height: 220),
          GestureDetector(
            onTap: () async {
              await recorder.toggleRecording();
              final isRecording = recorder.isRecording;
              setState(() {});
              if (isRecording) {
                timerController.startTimer();
              } else {
                timerController.stopTimer();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CryingAnalyzerApp(
                      soundRecorderr: recorder,
                    ),
                  ),
                );
              }
            },
            child: timerClock(
              controller: timerController,
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
