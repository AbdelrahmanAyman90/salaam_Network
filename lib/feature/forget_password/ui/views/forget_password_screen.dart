import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/write_phone_conumer.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WritePhoneConummer();
  }
}
