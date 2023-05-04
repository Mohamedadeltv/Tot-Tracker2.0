import 'package:flutter/material.dart';
import 'package:tottracker/api/sound_recorder.dart';
import 'package:tottracker/widgets/timer.dart';

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
    return Scaffold(
      backgroundColor: Colors.black26,
      body: buildStart(),
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    late IconData icon = isRecording ? Icons.stop : Icons.mic;
    late String text = isRecording ? 'STOP' : 'START';
    late Color primary = isRecording? Colors.red: Colors.white ;
    late Color onPrimary = isRecording ? Colors.white : Colors.black;
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100,),
          timerClock(controller: timerController),
          SizedBox(height: 60,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(175, 50),
                primary: primary,
                onPrimary: onPrimary),
            onPressed: () async {
              await recorder.toggleRecording();
              final isRecording = recorder.isRecording;
              setState(() {});
              if (isRecording) {
                timerController.startTimer();
              } else {
                timerController.stopTimer();
              }
            },
            icon: Icon(Icons.mic),
            label: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
