import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password_consummer.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('تحديث كلمة المرور'),
      ),
      body: const UpdatePasswordConsummer(),
    );
  }
}
