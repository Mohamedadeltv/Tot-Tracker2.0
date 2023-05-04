import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

final pathTosaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecordIntialised = false;
  bool get isRecording => _audioRecorder!.isRecording;
  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(
          "Microphone Permission is not granted");
    }
    await _audioRecorder!.openAudioSession();
    _isRecordIntialised = true;
  }

  void dispose() {
    if(!_isRecordIntialised) return;
    _audioRecorder?.closeAudioSession();
    _audioRecorder = null;
    _isRecordIntialised = false;
  }

  Future _record() async {
    if(!_isRecordIntialised) return;
    await _audioRecorder!.startRecorder(toFile: pathTosaveAudio);
  }

  Future _stop() async {
    if(!_isRecordIntialised) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
