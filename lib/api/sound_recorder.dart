import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecordInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording;
  int audioNumber = 1;

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
    final String fileName = 'audio-$audioNumber.aac';

    Directory currentDirectory = Directory.current;
    String projectDirectoryPath = currentDirectory.path;

    final String folderPath = '$projectDirectoryPath/$folderName';
    final String filePath = '$folderPath/$fileName';

    Directory folderDirectory = Directory(folderPath);
    folderDirectory.createSync(recursive: true);

    final pathToSaveAudio = '${folderDirectory.path}/$fileName';

    await _audioRecorder!.startRecorder(
      toFile: pathToSaveAudio,
      codec: Codec.aacADTS,
    );

    audioNumber++;
  }

  Future<void> _stop() async {
    if (!_isRecordInitialized) return;
    await _audioRecorder!.stopRecorder();
  }

  Future<void> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
