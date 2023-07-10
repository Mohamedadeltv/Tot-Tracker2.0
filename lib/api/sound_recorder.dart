import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../widgets/timer.dart';

class SoundRecorder {
  String _classProbabilitiesString = '';

  String? responseData;
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecordInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording;
  int audioNumber = 1;
  final timerController = TimerController();
  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(
          "Microphone Permission is not granted");
    }

    await _audioRecorder!.openAudioSession();
    _isRecordInitialized = true;
  }

  void dispose() {
    if (!_isRecordInitialized) return;
    _audioRecorder?.closeAudioSession();
    _audioRecorder = null;
    _isRecordInitialized = false;
  }

  Future<void> _record() async {
    if (!_isRecordInitialized) return;

    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final String folderName = 'my_audio_folder';
    final String fileName = 'audio-$audioNumber.wav';

    final folderPath = '${appDocumentsDirectory.path}/$folderName';
    final filePath = '$folderPath/$fileName';

    Directory(folderPath).createSync(recursive: true);

    final pathToSaveAudio = '$folderPath/$fileName';

    await _audioRecorder!.startRecorder(
      toFile: pathToSaveAudio,
      codec: Codec.pcm16WAV, // Use WAV codec for audio recording
    );

    print(filePath);
    audioNumber++;
  }

  Future<void> _stop() async {
    if (!_isRecordInitialized) return;

    timerController.stopTimer();
    await _audioRecorder!.stopRecorder();
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final String folderName = 'my_audio_folder';
    final String fileName = 'audio-${audioNumber - 1}.wav';

    final folderPath = '${appDocumentsDirectory.path}/$folderName';
    final filePath = '$folderPath/$fileName';

    final pathToSaveAudio = '$folderPath/$fileName';

    // Read the audio file as bytes
    final audioBytes = File(pathToSaveAudio).readAsBytesSync();

    // Convert audio bytes to Base64 string
    final audioBase64 = base64Encode(audioBytes);
    print(audioBase64);
    // Send audioBase64 to Flask server
    final ngrokUrl =
        'https://56e7-45-242-77-68.ngrok-free.app';
    final apiUrl = '$ngrokUrl/api/predict';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'audio': audioBase64,
        'sample_rate': '22050', // Replace with the actual sample rate
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> classProbabilities =
          jsonResponse['class_probabilities'];
      final List probabilities = classProbabilities.map((value) {
        return value.toStringAsFixed(2);
      }).toList();

      final classProbabilitiesString = probabilities.join(', ');

      print(classProbabilitiesString);
      _classProbabilitiesString = classProbabilitiesString;
      responseData = response.body;
      print(response.body);
    } else {
      print('Error sending audio to Flask server');
    }
  }

  String get classProbabilitiesString => _classProbabilitiesString;
  Future<void> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
