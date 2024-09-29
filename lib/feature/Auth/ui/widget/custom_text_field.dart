import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String msg;
  final Icon icons;
  final TextEditingController controllar;

  final String? Function(String?) validator;
  const CustomTextField(
      {Key? key,
      required this.msg,
      required this.icons,
      required this.controllar,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 235, 232, 232),
      ),
      padding: const EdgeInsets.only(right: 8, bottom: 5),
      child: TextFormField(
        controller: controllar,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: msg,
          prefixIcon: icons,
        ),
        validator: (value) {
          String? validationResult = validator(value);

          return validationResult;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
