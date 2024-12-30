import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/image_widget.dart';

class ActivUser extends StatelessWidget {
  const ActivUser({super.key, required this.userDate});
  final UserModel userDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Stack(
        children: [
          ImageUserWidget(userChats: userDate),
          Positioned(
            right: 0.h,
            bottom: 15.h,
            child: CircleAvatar(
              radius: 6.r,
              backgroundColor: const Color.fromARGB(255, 12, 231, 19),
            ),
          )
        ],
      ),
    );
  }
}
