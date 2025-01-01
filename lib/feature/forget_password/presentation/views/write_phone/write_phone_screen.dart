import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/forget_password/ui/views/write_phone/write_phone_conumer.dart';

class WritePhoneScreen extends StatelessWidget {
  const WritePhoneScreen({super.key});
  static const String routeName = 'writePhoneScreen';
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.1),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'استعادة كلمة المرور',
            style: TextStyles.bold18,
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: const WritePhoneConummer());
  }
}
