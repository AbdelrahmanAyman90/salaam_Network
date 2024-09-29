import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/feature/chat/cubit/cubit/chat_cubit.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/data/model/user_model.dart';

import 'package:halqahquran/feature/chat/ui/widget/home_chat/activ_user.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/tab_bar.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/top_part.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/quran_widgets/search_widget.dart';

class ChatHameScreen extends StatelessWidget {
  ChatHameScreen({super.key});
  FirebaseChatOperation f = FirebaseChatOperation();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        children: [
          //! top bar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: TopBarInChatScreen(),
          ),
          //!activ user
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: SizedBox(
              height: 80.h,
              child: StreamBuilder<List<UserModel>>(
                  stream: f.getActiveUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      log(snapshot.error.toString());
                      return Text("Error: ${snapshot.error}");
                    } else {}
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ActivUser(
                          name: snapshot.data![index].name,
                        );
                      },
                    );
                  }),
            ),
          ),
          //!search bar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SearchTextField(
              hint: "بحث عن مستخدم..",
            ),
          ),
          //!user chat
          Expanded(child: TapBarChat())
        ],
      ),
    );
  }
}
