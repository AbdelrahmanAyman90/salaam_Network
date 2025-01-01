import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:halqahquran/core/service/bloc_observ.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/data/repos/stream_repo_impl.dart';
import 'package:halqahquran/feature/stream/domain/repos/stream_repo.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class HostStreamPage extends StatelessWidget {
  const HostStreamPage(
      {super.key, required this.streamModel, required this.streamCubit});
  final StreamModel streamModel;
  static const routeName = "hostStreamPage";
  // final StreamRepo streamRepo = getIt<StreamRepo>();
  final StreamCubit streamCubit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
          appID: int.parse(dotenv.env['StreamId']!),
          appSign: dotenv.env['StreamSign']!,
          userID: streamModel.userId,
          userName: streamModel.hostUserName,
          liveID: streamModel.streamId,
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
                streamCubit.endStream(
                  streamId: streamModel.streamId,
                  imageBeforUpload: streamModel.imageBeforUpload,
                );
                // streamRepo.endStream(
                //     streamId: streamModel.streamId,
                //     imageBeforUpload: streamModel.imageBeforUpload);
                defaultAction.call();
              }
            },
          ),
          config: ZegoUIKitPrebuiltLiveStreamingConfig.host()),
    );
  }
}
