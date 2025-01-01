import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/core/util/asset_app.dart';
import 'package:halqahquran/feature/quran/ui/widgets/audio_operation_widget.dart';

class AudioPlayScreen extends StatelessWidget {
  final String nameSorah;
  final String linkAudio;
  final String rederName;
  const AudioPlayScreen(
      {super.key,
      required this.nameSorah,
      required this.linkAudio,
      required this.rederName});
  static const routeName = "AudioPlayScreen";
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display Image and Sorah Name
            Container(
              height: 400,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AssetApp.quranImage,
                    ),
                    fit: BoxFit.fill),
              ),
              child: Column(
                children: [
                  AppSize.hight(80),
                  Text(
                    nameSorah,
                    style: TextAppStyle.arabicStyle.copyWith(
                      color: Colors.black,
                      fontSize: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
            AppSize.hight(20),
            Text(
              "الشيخ $rederName",
              style: TextAppStyle.subTittel.copyWith(fontSize: 32),
            ),
            // Audio Controls: Slider, Play/Pause, Next/Previous
            AudioOperation(
              linkAudio: linkAudio,
            )
          ],
        ),
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;

  const SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0.0,
          max: duration.inMilliseconds.toDouble(),
          value: position.inMilliseconds
              .toDouble()
              .clamp(0.0, duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            onChanged(Duration(milliseconds: value.round()));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDuration(position)),
            Text(_formatDuration(duration)),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
