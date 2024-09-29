import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/chats_list.dart';

class TapBarChat extends StatefulWidget {
  TapBarChat({super.key});

  @override
  State<TapBarChat> createState() => _TapBarChatState();
}

class _TapBarChatState extends State<TapBarChat> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: "1 to 1" and "Group"

      child: Container(
        color: AppColor.primeColor,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white.withOpacity(.5),
            bottom: TabBar(
              unselectedLabelStyle:
                  TextStyle(color: Colors.black, fontSize: 16.sp),
              unselectedLabelColor: Colors.black,
              indicatorColor: AppColor.primeColor,
              indicatorWeight: 4.w,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColor.primeColor,
              labelStyle: TextStyle(fontSize: 14.sp),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.person,
                    size: 22.sp,
                  ),
                  text: '1 to 1',
                ),
                Tab(
                  icon: Icon(
                    Icons.group,
                    size: 22.sp,
                  ),
                  text: 'Group',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //! widget 1
              ChatUsersList(),
              //widget2
              const Center(
                child: Text('Group Chats'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
