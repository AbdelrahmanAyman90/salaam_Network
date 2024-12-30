import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/feature/chat/data/model/chat_model.dart';
import 'package:halqahquran/feature/chat/data/repo/chat_repo_impl.dart';
import 'package:halqahquran/feature/chat/ui/screen/chat_page.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/delet_user.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/user_chat_widget.dart';
import 'package:page_transition/page_transition.dart';

class ChatUsersList extends StatelessWidget {
  ChatUsersList({super.key});
  final FirebaseService firebaseService = FirebaseService();
  final ChatRepoImpl firebaseChatOperation = ChatRepoImpl();

  void showDeleteConfirmation(
      BuildContext context, String chatId, String userNmae) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmation(
          userNmae: userNmae,
          chatId: chatId,
          firebaseChatOperation: firebaseChatOperation,
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
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/empty.svg',
                    width: 150.w,
                    height: 150.h,
                  ),
                  Text(
                    'لايوجد رسائل',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<ChatsModel> userChats = snapshot.data!;
            log(userChats.length.toString());
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
                                firebaseService.getFirebaseUserId()
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
                        child: MassagesScreen(
                          chatId: userChats[index].chatId,
                          userDate: userChats[index].currentUser.id ==
                                  firebaseService.getFirebaseUserId()
                              ? userChats[index].otherUser
                              : userChats[index].currentUser,
                        ),
                      ),
                    );
                  },
                  child: ChatUserWidget(
                    userChats: userChats[index],
                    firebaseService: firebaseService,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
