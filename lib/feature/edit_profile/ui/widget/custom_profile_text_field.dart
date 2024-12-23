import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/edit_profile/ui/cubit/edit_profile_cubit.dart';

class CustomEditProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String oldcontroller;
  CustomEditProfileTextField(
      {required this.controller, required this.oldcontroller});
  @override
  _CustomEditProfileTextFieldState createState() =>
      _CustomEditProfileTextFieldState();
}

class _CustomEditProfileTextFieldState
    extends State<CustomEditProfileTextField> {
  final TextEditingController controller = TextEditingController();

  bool _isEditable = false;

  void _toggleEditMode() {
    setState(() {
      _isEditable = !_isEditable;
      if (_isEditable) {
        widget.controller.clear();
      } else {
        widget.controller.text = widget.oldcontroller; // reset for old
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is UserUpdateSuccses) {
          setState(() {
            _isEditable = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 223, 226, 225),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: _isEditable ? '' : widget.oldcontroller,
            hintStyle: const TextStyle(fontSize: 18, color: AppColor.subText),
            suffixIcon: IconButton(
              icon: Icon(
                _isEditable ? Icons.cancel : Icons.edit,
                color: AppColor.primeColor,
              ),
              onPressed: _toggleEditMode,
            ),
          ),
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Field cannot be empty';
          //   }
          //   return null;
          // },
          readOnly: !_isEditable,
        ),
      ),
    );
  }
}
