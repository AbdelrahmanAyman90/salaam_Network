import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon? icons;
  final TextEditingController controllar;
  final TextInputType textInputType;

  final String? Function(String?) validator;
  const CustomTextField(
      {Key? key,
      required this.textInputType,
      required this.hintText,
      this.icons,
      required this.controllar,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controllar,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        prefixIcon: icons,
        fillColor: AppColor.fillTextField,
        filled: true,
      ),
      validator: (value) {
        String? validationResult = validator(value);

        return validationResult;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
