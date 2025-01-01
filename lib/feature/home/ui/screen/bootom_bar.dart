import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/chat/ui/screen/chat_screen.dart';
import 'package:halqahquran/feature/home/ui/screen/home_body.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';
import 'package:halqahquran/feature/notfication/workmanager_helper.dart';
import 'package:halqahquran/feature/profile/ui/views/profile_screen.dart';
import 'package:halqahquran/feature/stream/ui/views/stream_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  static const String routeName = "bottombar";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curentIndex = 0;
  final screen = [
    const HomeScreenBody(),
    const ChatScreen(),
    const StreamView(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    initServices();
  }

  Future<void> initServices() async {
    await Future.wait([
      LocalNotificationService.init(),
      WorkManagerService().init(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SafeScaffold(
        bottomNavigationBar: Container(
          color: AppColor.primeColor,
          child: BottomNavigationBar(
            // unselectedIconTheme: const IconThemeData(color: Colors.black),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "الرئيسيه"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat), label: "المحادثات"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_call), label: "بث مباشر"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "الحساب"),
            ],
            currentIndex: curentIndex,
            selectedItemColor: AppColor.primeColor,
            onTap: (value) => setState(() => curentIndex = value),
          ),
        ),
        body: screen[curentIndex],
      );
    });
  }
}
