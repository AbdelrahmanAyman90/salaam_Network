import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';

import 'dart:async';
import 'package:pinput/pinput.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final TextEditingController codeController = TextEditingController();
  late Timer timer;
  int countdown = 60; // Initial countdown time in seconds
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    timer.cancel();
    codeController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      countdown = 60;
      canResend = false;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    // Logic to resend the code
    if (countdown == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم اعادة الارسال')),
      );
      _startCountdown();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لايمكنك الارسال لا بعد 60 ثانيه ')),
      );
    }
  }

  Future<void> _verifyCode() async {
    // Logic to verify the code
    final code = codeController.text.trim();
    if (code.isEmpty || code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك ادخل الرمز المرسل لك')),
      );
      return;
    }

    await context.read<ForgetPasswordCubit>().verifyCode(smsCode: code);

    // Navigate to the next page after successful verification
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

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
          'التحقق من الرمز',
          style: TextStyles.bold18,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "ادخل الرمز المرسل لك على رقم الجوال",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Pinput(
              controller: codeController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.primeColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              countdown > 0
                  ? "إعادة إرسال الرمز بعد $countdown ثانية"
                  : "يمكنك إعادة إرسال الرمز الآن",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resendCode,
              child: const Text("إعادة إرسال الرمز"),
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: _verifyCode,
              widgetButton: Text(
                'التحقق من الرمز',
                style: TextStyles.semiBold18.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
