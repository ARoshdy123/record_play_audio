import 'package:flutter/material.dart';
/// to start/stop recording audio.
class RecordButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onPressed;

  const RecordButton({
    super.key,
    required this.isRecording,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(isRecording ? 'Stop Recording' : 'Record Audio'),
    );
  }
}
