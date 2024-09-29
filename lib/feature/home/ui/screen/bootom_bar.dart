import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/ui/screen/home_chat_screen.dart';
import 'package:halqahquran/feature/home/ui/screen/home_body.dart';
import 'package:intl/intl.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  int curentIndex = 0;
  final screen = [
    const HomeScreen(),
    ChatHameScreen(),
    const Center(child: Text("stream")),
    const Center(child: Text("info")),
  ];

  FirebaseChatOperation? f; // Declare FirebaseChatOperation here

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Start observing lifecycle events

    f = FirebaseChatOperation(); // Initialize FirebaseChatOperation
    f!.updateLastSean(status: 'online'); // Set user status to online on start
  }

  @override
  void dispose() {
    f!.updateLastSean(
      status: convertToArabicAmPm(DateFormat.Hm().format(DateTime.now())),
    ); // Set user status to offline on app close
    WidgetsBinding.instance
        .removeObserver(this); // Stop observing lifecycle events
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      f!.updateLastSean(
          status: convertToArabicAmPm(DateFormat.Hm().format(DateTime
              .now()))); // Set user status to offline when app goes to background
    } else if (state == AppLifecycleState.resumed) {
      f!.updateLastSean(
          status: 'online'); // Set user status to online when app resumes
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      bottomNavigationBar: Container(
        color: AppColor.primeColor,
        child: BottomNavigationBar(
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white.withOpacity(.89),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_call),
                label: "Stream",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: curentIndex,
            selectedItemColor: AppColor.primeColor,
            onTap: (value) => setState(() => curentIndex = (value))),
      ),
      body: screen[curentIndex],
    );
  }
}
