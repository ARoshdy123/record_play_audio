import 'package:flutter/material.dart';

/// to play or stop the recorded audio.
class PlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const PlayButton({
    Key? key,
    required this.isPlaying,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(isPlaying ? 'Stop Playing' : 'Play Audio'),
    );
  }
}
