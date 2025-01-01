import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final Color? color;
  const PasswordField({required this.passwordController, this.color});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _isObscured,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: "كلمه المرور",
        fillColor: AppColor.fillTextField,
        filled: true,
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Color.fromARGB(255, 99, 98, 98),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: widget.color ?? const Color.fromARGB(255, 99, 98, 98),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'من فضلك ادخل كلمه المرور';
        }

        return null;
      },
    );
  }
}
