import 'package:flutter/material.dart';
import 'package:record_play_audio/widgets/play_button.dart';
import 'package:record_play_audio/widgets/record_button.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  bool isRecording = false;
  bool isRecorded = false;
  String? audioFilePath;

  void onRecordingComplete(String filePath) {
    setState(() {
      isRecording = false;
      isRecorded = true;
      audioFilePath = filePath;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecordButton(
              isRecording: isRecording,
              onRecordingComplete: onRecordingComplete,
            ),
            if (isRecorded) const SizedBox(height: 20),
            if (isRecorded)
              PlayButton(
                audioFilePath: audioFilePath!,
              ),
          ],
        ),
      ),
    );
  }
}