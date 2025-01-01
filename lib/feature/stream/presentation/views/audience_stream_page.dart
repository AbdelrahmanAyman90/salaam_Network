import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class AudienceStreamPage extends StatelessWidget {
  const AudienceStreamPage({super.key, required this.streamModel});
  final StreamModel streamModel;
  static const routeName = 'AudienceStreamPage';
  @override
  Widget build(BuildContext context) {
    log('streamId: ${streamModel.streamId}');
    log('userId: ${getUserData().id}');
    log('userName: ${getUserData().name}');
    return SafeArea(
      child: SafeArea(
        child: ZegoUIKitPrebuiltLiveStreaming(
          appID: int.parse(dotenv.env['StreamId']!),
          appSign: dotenv.env['StreamSign']!,
          userID: getUserData().id,
          userName: getUserData().name,
          liveID: streamModel.streamId,
          config: ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
          events: ZegoUIKitPrebuiltLiveStreamingEvents(
            onEnded: (
              ZegoLiveStreamingEndEvent event,
              VoidCallback defaultAction,
            ) {
              if (ZegoLiveStreamingEndReason.hostEnd == event.reason) {
                if (event.isFromMinimizing) {
                  ZegoUIKitPrebuiltLiveStreamingController().minimize.hide();
                } else {
                  Navigator.pop(context);
                }
              } else {
                defaultAction.call();
              }
            },
          ),
        ),
      ),
    );
  }
}
