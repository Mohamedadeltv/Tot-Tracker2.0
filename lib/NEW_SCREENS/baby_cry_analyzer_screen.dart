// import 'package:flutter/material.dart';
// import 'package:tottracker/NEW_SCREENS/sky.dart';
// import 'package:tottracker/api/sound_recorder.dart';
// import 'package:tottracker/widgets/timer.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:tottracker/api/notification_helper.dart';

// import 'cry_analysis.dart';

// class BabyCryAnalyzerScreen extends StatefulWidget {
//   @override
//   _BabyCryAnalyzerScreenState createState() => _BabyCryAnalyzerScreenState();
// }

// class _BabyCryAnalyzerScreenState extends State<BabyCryAnalyzerScreen> {
//   final timerController = TimerController();
//   final recorder = SoundRecorder();

//   @override
//   void initState() {
//     super.initState();
//     recorder.init();
//   }

//   @override
//   void dispose() {
//     recorder.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: SkyWidget(),
//           ),
//           buildStart(),
//         ],
//       ),
//     );
//   }

//   Widget buildStart() {
//     final isRecording = recorder.isRecording;
//     late IconData icon = isRecording ? Icons.stop : Icons.mic;
//     late Color primary = isRecording ? Colors.red : Colors.white;
//     late Color onPrimary = isRecording ? Colors.white : Colors.black;

//     return Center(
//       child: Column(
//         children: [
//           SizedBox(height: 100),
//           GestureDetector(
//             onTap: () async {
//               await recorder.toggleRecording();
//               final isRecording = recorder.isRecording;
//               setState(() {});
//               if (isRecording) {
//                 timerController.startTimer();
//               } else {
//                 timerController.stopTimer();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CryingAnalyzerApp(),
//                   ),
//                 );
//               }
//             },
//             child: timerClock(
//               controller: timerController,
//             ),
//           ),
//           SizedBox(height: 60),
//         ],
//       ),
//     );
//   }
// }
