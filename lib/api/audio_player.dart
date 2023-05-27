// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioPlayerWidget extends StatefulWidget {
//   final String audioFilePath;

//   AudioPlayerWidget({required this.audioFilePath});

//   @override
//   _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
// }

// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   AudioPlayer audioPlayer = AudioPlayer();
//   PlayerState playerState = PlayerState.STOPPED;

//   @override
//   void initState() {
//     super.initState();
//     audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       setState(() {
//         playerState = state;
//       });
//     } as void Function(Enum event)?);
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   Future<void> playAudio() async {
//     await audioPlayer.play(
//       //widget.audioFilePath as Source,
//     );
//   }

//   Future<void> stopAudio() async {
//     await audioPlayer.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           icon: Icon(playerState == PlayerState.PLAYING
//               ? Icons.pause
//               : Icons.play_arrow),
//           onPressed: () {
//             if (playerState == PlayerState.PLAYING) {
//               stopAudio();
//             } else {
//               playAudio();
//             }
//           },
//         ),
//         Text(playerState == PlayerState.PLAYING ? 'Playing' : 'Stopped'),
//       ],
//     );
//   }
// }

// enum PlayerState {
//   STOPPED,
//   PLAYING,
// }
