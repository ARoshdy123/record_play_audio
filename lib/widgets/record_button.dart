import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordButton extends StatefulWidget {
  final bool isRecording;
  final Function(String) onRecordingComplete;

  const RecordButton({
    super.key,
    required this.isRecording,
    required this.onRecordingComplete,
  });

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder.openRecorder();
  }

  Future<void> _startRecording() async {
    setState(() => _isRecording = true);
    const path = 'audio_record.aac';
    await _audioRecorder.startRecorder(toFile: path);
  }

  Future<void> _stopRecording() async {
    final path = await _audioRecorder.stopRecorder();
    setState(() => _isRecording = false);
    widget.onRecordingComplete(path!);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isRecording ? _stopRecording : _startRecording,
      child: Text(_isRecording ? 'Stop Recording' : 'Record Audio'),
    );
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
  }
}