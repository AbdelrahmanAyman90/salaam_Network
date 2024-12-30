import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/chat/ui/screen/chat_screen.dart';
import 'package:halqahquran/feature/home/ui/screen/home_body.dart';
import 'package:halqahquran/feature/profile/ui/views/profile_screen.dart';
import 'package:halqahquran/feature/stream/ui/views/stream_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int curentIndex = 0;
  final screen = [
    const HomeScreen(),
    const ChatScreen(),
    const StreamView(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      bottomNavigationBar: Container(
        color: AppColor.primeColor,
        child: BottomNavigationBar(
          // unselectedIconTheme: const IconThemeData(color: Colors.black),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسيه"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "المحادثات"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "بث مباشر"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "الحساب"),
          ],
          currentIndex: curentIndex,
          selectedItemColor: AppColor.primeColor,
          onTap: (value) => setState(() => curentIndex = value),
        ),
      ),
      body: screen[curentIndex],
    );
  }
}
