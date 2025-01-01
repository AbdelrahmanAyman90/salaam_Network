import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';

class UpdatePasswordBody extends StatefulWidget {
  const UpdatePasswordBody({super.key});

  @override
  _UpdatePasswordBodyState createState() => _UpdatePasswordBodyState();
}

class _UpdatePasswordBodyState extends State<UpdatePasswordBody> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // New Password Field
            TextFormField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور الجديدة';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Confirm Password Field
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى تأكيد كلمة المرور';
                }
                if (value != _newPasswordController.text) {
                  return 'كلمات المرور غير متطابقة';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            // Update Button
            CustomButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final cubit = context.read<ForgetPasswordCubit>();
                  final newPassword = _newPasswordController.text;
                  // Call the update password logic from the cubit
                  await cubit.updatePassword(newPassword: newPassword);
                }
              },
              widgetButton: Text(
                'تحديث كلمة المرور',
                style: TextStyles.semiBold18.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
