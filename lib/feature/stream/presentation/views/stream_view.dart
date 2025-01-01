import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/feature/stream/domain/repos/stream_repo.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:halqahquran/feature/stream/ui/views/stream_view_consummer.dart';

class StreamView extends StatelessWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StreamCubit(
        streamRepo: getIt<StreamRepo>(),
      ),
      child: const StreamViewConsummer(),
    );
  }
}
