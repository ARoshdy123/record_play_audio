import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:record_play_audio/widgets/play_button.dart';
import 'package:record_play_audio/widgets/record_button.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  bool _isRecorderInitialized = false;
  bool _isPlayerInitialized = false;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    initRecorder();
    initPlayer();
  }

  /// Initialize the audio recorder and request necessary permissions.
  Future<void> initRecorder() async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder!.openRecorder();

    setState(() {
      _isRecorderInitialized = true;
    });
  }

  /// Initialize the audio player.
  Future<void> initPlayer() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openPlayer();
    setState(() {
      _isPlayerInitialized = true;
    });
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    _audioPlayer?.closePlayer();
    _audioRecorder = null;
    _audioPlayer = null;
    super.dispose();
  }

  /// Start recording audio.

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) return;

    // Use a fixed file name as the file path from documentation.
    String filePath = 'flutter_sound_example.aac';
    await _audioRecorder!.startRecorder(
      toFile: filePath,
    );
    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath; // Save file path for later playback
    });
  }

  /// Stop the recording.
  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  /// Toggle recording state: start if not recording, stop if recording.
  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  /// Play or stop playing the recorded audio.
  Future<void> _playRecording() async {
    if (!_isPlayerInitialized || _recordedFilePath == null) return;

    if (_isPlaying) {
      await _audioPlayer!.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer!.startPlayer(
        fromURI: _recordedFilePath,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Audio')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Always show the Record button.
            RecordButton(
              isRecording: _isRecording,
              onPressed: _toggleRecording,
            ),
            SizedBox(height: 20),
            // Show the Play button only if a recording exists and not currently recording.
            if (_recordedFilePath != null && !_isRecording)
              PlayButton(
                isPlaying: _isPlaying,
                onPressed: _playRecording,
              ),
          ],
        ),
      ),
    );
  }
}