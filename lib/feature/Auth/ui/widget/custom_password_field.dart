import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordField({required this.passwordController});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      // Adjust height based on error state
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 235, 232, 232),
      ),
      padding: const EdgeInsets.only(right: 8, bottom: 5),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: _isObscured,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "كلمه المرور",
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
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'من فضلك ادخل كلمه المرور';
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
