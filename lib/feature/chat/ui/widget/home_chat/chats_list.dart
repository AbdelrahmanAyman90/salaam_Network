import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/data/model/chat_model.dart';
import 'package:halqahquran/feature/chat/ui/screen/chat_page.dart';
import 'package:page_transition/page_transition.dart';

class ChatUsersList extends StatelessWidget {
  ChatUsersList({super.key});
  final FirebaseService firebaseid = FirebaseService();
  final FirebaseChatOperation firebaseChatOperation = FirebaseChatOperation();

  void showDeleteConfirmation(
      BuildContext context, String chatId, String userNmae) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"$userNmae"',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Are you sure you want to delete this user?"),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
                onTap: () async {
                  bool stuts =
                      await firebaseChatOperation.deletUser(chatId: chatId);
                  if (stuts) {
                    Navigator.pop(context);
                    showCustomSnackBar(context, "delet '${userNmae}' succses",
                        Icons.check, true);
                    // Close bottom sheet on cancel
                  } else {
                    showCustomSnackBar(context, "delet '${userNmae}' fiald",
                        Icons.close, false);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet on cancel
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: StreamBuilder<List<ChatsModel>>(
        stream: firebaseChatOperation.getUserChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No chats available');
          } else {
            List<ChatsModel> userChats = snapshot.data!;

            return ListView.separated(
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: Divider(
                    color: Colors.grey,
                    thickness: .3.h,
                  ),
                );
              },
              itemCount: userChats.length,
              itemBuilder: (context, index) {
                return InkWell(
                  //!long
                  onLongPress: () {
                    showDeleteConfirmation(
                        context,
                        userChats[index].chatId,
                        userChats[index].currentUser.id ==
                                firebaseid.getFirebaseUserId()
                            ? userChats[index].otherUser.name
                            : userChats[index].currentUser.name);
                  },
                  //! preesd
                  onTap: () async {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 400),
                        child: ChatPage(
                          chatId: userChats[index].chatId,
                          userDate: userChats[index].currentUser.id ==
                                  firebaseid.getFirebaseUserId()
                              ? userChats[index].otherUser
                              : userChats[index].currentUser,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                      leading: Container(
                        width: 56
                            .sp, // Width and height are based on the CircleAvatar radius
                        height: 56.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .circle, // Ensure the container is circular
                          border: Border.all(
                            color: AppColor
                                .primeColor, // Use your prime color here
                            width: 1.0, // Set the border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28.sp,
                          backgroundColor: Colors.grey[
                              200], // Optional: Set a background color for the CircleAvatar
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userChats[index].otherUser.image ??
                                  "https://photoszone.net/wp-content/uploads/2024/05/no-dp_16.webp",
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        userChats[index].currentUser.id ==
                                firebaseid.getFirebaseUserId()
                            ? userChats[index].otherUser.name
                            : userChats[index].currentUser.name,
                        style: TextAppStyle.normalTittel
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: userChats[index].lastMessage!.trim() == 'image'
                          ? Row(
                              children: [
                                Text('Photo'),
                                AppSize.width(4),
                                const Icon(
                                  Icons.image,
                                  size: 18,
                                ),
                              ],
                            )
                          : Text(userChats[index].lastMessage.toString()),
                      trailing: Text(
                        userChats[index].timelastMessage.toString(),
                        style: TextAppStyle.subTittel,
                      )),
                );
              },
            );
          }
        },
      ),
    );
  }
}
