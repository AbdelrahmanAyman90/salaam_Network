import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/core/status/show_toats.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/chat/ui/cubit/cubit/chat_cubit.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/image_widget.dart';

class BottomSheatInChatScree extends StatelessWidget {
  const BottomSheatInChatScree({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChatCubit>();
    return SizedBox(
      height: 400.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "ابدأ المحادثه مع اي مستخدم !!",
              style:
                  TextAppStyle.mainTittel.copyWith(color: AppColor.primeColor),
            ),
            AppSize.hight(10),
            BlocConsumer<ChatCubit, ChatState>(listener: (context, state) {
              if (state is GetAllUserFail) {
                Navigator.pop(context);
              } else if (state is CreatNewChatSuccses) {
                showCustomSnackBar(context, state.massage, Icons.check, true);
              } else if (state is CreatNewChatFail) {
                showToats(state.errorMassage);
              }
            }, builder: (context, state) {
              if (state is GetAllUserLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primeColor,
                  ),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      thickness: .3.h,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.allUserList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          ImageUserWidget(userChats: cubit.allUserList[index]),
                      title: Text(
                        cubit.allUserList[index].name,
                        style: TextAppStyle.normalTittel
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        cubit.allUserList[index].email,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          cubit.creatNewChat(
                              otherUserId: cubit.allUserList[index].id,
                              OtherName: cubit.allUserList[index].name);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
