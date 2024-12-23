import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/edit_profile/ui/widget/custom_profile_text_field.dart';

class EditProfileField extends StatelessWidget {
  EditProfileField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controllar,
  });
  final String title;
  final String hintText;
  final controllar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: TextAppStyle.normalTittel,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: CustomEditProfileTextField(
            oldcontroller: hintText,
            controller: controllar,
          ),
        ),
      ],
    );
  }
}
