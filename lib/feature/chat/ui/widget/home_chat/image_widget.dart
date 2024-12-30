import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/chat/data/model/chat_model.dart';

class ImageUserWidget extends StatelessWidget {
  const ImageUserWidget({super.key, required this.userChats});
  final UserModel userChats;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w, // Width and height are based on the CircleAvatar radius
      height: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Ensure the container is circular
        border: Border.all(
          color: AppColor.primeColor, // Use your prime color here
          width: 2.0, // Set the border width
        ),
      ),
      child: ClipOval(
        child: userChats.image != null
            ? CachedNetworkImage(
                imageUrl: userChats.image!,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              )
            : Image.asset(
                "assets/images/no-dp_16.webp",
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
//userChats.otherUser.image