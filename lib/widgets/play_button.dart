import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PlayButton extends StatefulWidget {
  final String audioFilePath;

  const PlayButton({
    super.key,
    required this.audioFilePath,
  });

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    await _audioPlayer.openPlayer();
  }

  Future<void> _playAudio() async {
    setState(() => _isPlaying = true);
    await _audioPlayer.startPlayer(fromURI: widget.audioFilePath);
    setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isPlaying ? null : _playAudio,
      child: const Text('Play Audio'),
    );
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    super.dispose();
  }
}