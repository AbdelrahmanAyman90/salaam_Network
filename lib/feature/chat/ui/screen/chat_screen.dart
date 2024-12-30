import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:halqahquran/feature/chat/data/repo/chat_repo_impl.dart';
import 'package:halqahquran/feature/chat/domain/repo/chat_repo.dart';
import 'package:halqahquran/feature/chat/ui/cubit/cubit/chat_cubit.dart';
import 'package:halqahquran/feature/chat/ui/screen/home_chat_screen.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  ChatRepoImpl? chatFirebaseOperation; // Declare FirebaseChatOperation here

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Start observing lifecycle events

    chatFirebaseOperation = ChatRepoImpl(); // Initialize FirebaseChatOperation
    chatFirebaseOperation!
        .updateLastSean(status: 'online'); // Set user status to online on start
    log("ppppppppppppppppppppp(init)ppppppppppppppppppppppppppp");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      chatFirebaseOperation!.updateLastSean(
          status: convertToArabicAmPm(timeFormat.format(DateTime
              .now()))); // Set user status to offline when app goes to background
    } else if (state == AppLifecycleState.resumed) {
      chatFirebaseOperation!.updateLastSean(
          status: 'online'); // Set user status to online when app resumes
    }
    log("ppppppppppppppppppppp(two)ppppppppppppppppppppppppppp");
  }

  @override
  void dispose() {
    chatFirebaseOperation!.updateLastSean(
        status: convertToArabicAmPm(timeFormat.format(
            DateTime.now()))); // Set user status to offline on app close
    WidgetsBinding.instance.removeObserver(this);
    // Stop observing lifecycle events
    log("ppppppppppppppppppppp(final)ppppppppppppppppppppppppppp");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeChatScreenBody();
  }
}
