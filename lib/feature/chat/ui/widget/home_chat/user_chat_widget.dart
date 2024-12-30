import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/chat/data/model/chat_model.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/image_widget.dart';

class ChatUserWidget extends StatelessWidget {
  final ChatsModel userChats;
  final FirebaseService firebaseService;
  const ChatUserWidget(
      {super.key, required this.userChats, required this.firebaseService});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageUserWidget(
          userChats:
              userChats.currentUser.id == firebaseService.getFirebaseUserId()
                  ? userChats.otherUser
                  : userChats.currentUser),
      title: Text(
          userChats.currentUser.id == firebaseService.getFirebaseUserId()
              ? userChats.otherUser.name
              : userChats.currentUser.name,
          style: TextStyles.semiBold22),
      subtitle: userChats.lastMessage!.trim() == 'image'
          ? Row(
              children: [
                const Text('Photo'),
                AppSize.width(4),
                const Icon(
                  Icons.image,
                  size: 18,
                ),
              ],
            )
          : Text(userChats.lastMessage.toString()),
      trailing: Text(
        userChats.timelastMessage.toString(),
        style: TextStyles.regular18,
      ),
    );
  }
}
