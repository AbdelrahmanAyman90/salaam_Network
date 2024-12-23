import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';

import 'package:halqahquran/feature/pray_time/ui/views/pray_screen_body.dart';

class PrayScreen extends StatelessWidget {
  PrayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrayScreenBody();
  }
}
