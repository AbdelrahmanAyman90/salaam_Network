import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:halqahquran/feature/stream/ui/views/stream_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class StreamViewConsummer extends StatelessWidget {
  const StreamViewConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StreamCubit, StreamCubitState>(
      listener: (context, state) {
        if (state is CreateStreamError) {
          showCustomSnackBar(context, state.errorMessage, Icons.error, false);
        } else if (state is CreateStreamSuccess) {
          Navigator.pop(context);
        } else if (state is CreateStreamLoading) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CreateStreamLoading,
          progressIndicator: Center(
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'جاري تحضير البث',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          child: const StreamViewBody(),
        );
      },
    );
  }
}
