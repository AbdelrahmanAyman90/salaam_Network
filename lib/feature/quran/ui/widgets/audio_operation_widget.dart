import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/show_toats.dart';
import 'package:halqahquran/feature/quran/ui/screen/audio_player_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart'; // For combining streams

class AudioOperation extends StatefulWidget {
  const AudioOperation({super.key, required this.linkAudio});
  final String linkAudio;
  @override
  State<AudioOperation> createState() => _AudioOperationState();
}

class _AudioOperationState extends State<AudioOperation> {
  late AudioPlayer _audioPlayer;
  bool isMuted = false;
  bool isRepeating = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.linkAudio);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Audio Slider
          StreamBuilder<PositionData>(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                onChanged: (newPosition) {
                  _audioPlayer.seek(newPosition);
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rewind 10 seconds
              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () {
                  final newPosition =
                      _audioPlayer.position - const Duration(seconds: 10);
                  _audioPlayer.seek(newPosition);
                },
              ),

              // Play / Pause Button
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 64.0,
                      height: 64.0,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (playing != true) {
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 64.0,
                      onPressed: _audioPlayer.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      iconSize: 64.0,
                      onPressed: _audioPlayer.pause,
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: 64.0,
                      onPressed: () => _audioPlayer.seek(Duration.zero),
                    );
                  }
                },
              ),

              // Forward 10 seconds
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () {
                  final newPosition =
                      _audioPlayer.position + const Duration(seconds: 10);
                  _audioPlayer.seek(newPosition);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mute/Unmute Button
              IconButton(
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                ),
                onPressed: () {
                  setState(() {
                    isMuted = !isMuted;
                    _audioPlayer.setVolume(isMuted ? 0.0 : 1.0);
                  });
                },
              ),

              // Repeat Button
              IconButton(
                icon: Icon(
                  isRepeating ? Icons.repeat_one : Icons.repeat,
                ),
                onPressed: () {
                  showToats(isRepeating
                      ? "تم الغاء وضع التكرار"
                      : "تم تفعيل وضع التكرار");
                  setState(() {
                    isRepeating = !isRepeating;
                    _audioPlayer
                        .setLoopMode(isRepeating ? LoopMode.one : LoopMode.off);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
