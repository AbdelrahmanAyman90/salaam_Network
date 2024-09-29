import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/muslem_service/cubit/cubit/sevice_muslm_cubit.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/read_zekr_and_hadeth_screen.dart';
import 'package:page_transition/page_transition.dart';

class ServiceModel {
  String name;
  Icon iconService;
  final Function(MuslumServiceCubit, int) onPressed;
  ServiceModel({
    required this.iconService,
    required this.name,
    required this.onPressed,
  });
}
