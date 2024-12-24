import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/data/model/massage_model.dart';
import 'package:halqahquran/feature/chat/ui/widget/chat_page/image_massage_model.dart';
import 'package:halqahquran/feature/chat/ui/widget/chat_page/massage_input.dart';
import 'package:halqahquran/feature/chat/ui/widget/chat_page/text_model.dart';
import 'package:halqahquran/feature/chat/ui/widget/chat_page/top_chat_page.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
    required this.chatId,
    required this.userDate,
  });
  final String chatId;
  final UserModel userDate;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseChatOperation chatOperation = FirebaseChatOperation();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    //ensures that the action happens after the rendering is complete.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatOperation.markMessagesAsRead(widget.chatId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Column(
        children: [
          TopCahtPage(
            userData: widget.userDate,
            firebaseChatOperation: chatOperation,
          ),
          // Expanded area for the chat messages (empty for now)
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: chatOperation.getMassage(chatId: widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: AppColor.primeColor,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const Text(
                            'Something went wrong, please try again later'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {}); // Trigger refresh
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (snapshot.hasData) {
                    List<MessageModel> messagesDataList = snapshot.data!;
                    return ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        log(messagesDataList[index].senderId);

                        return Column(
                          children: [
                            messagesDataList[index].type.trim() == 'image'
                                ? ImageMassage(
                                    urlMassage:
                                        messagesDataList[index].messageText,
                                    isSender:
                                        messagesDataList[index].senderId ==
                                            chatOperation.firebaseService
                                                .getFirebaseUserId(),
                                    seen: messagesDataList[index].isRead,
                                    time:
                                        messagesDataList[index].timeSendMassage,
                                  )
                                : TextModelWidgetChat(
                                    massage:
                                        messagesDataList[index].messageText,
                                    isSender:
                                        messagesDataList[index].senderId ==
                                            chatOperation.firebaseService
                                                .getFirebaseUserId(),
                                    seen: messagesDataList[index].isRead,
                                    time:
                                        messagesDataList[index].timeSendMassage,
                                  ),
                          ],
                        );
                      },
                      itemCount: messagesDataList.length,
                    );
                  } else {
                    return Container();
                  }
                }
              },
            ),
          ),
          AppSize.hight(8),
          // Message input area at the bottom
          MessageInputWidget(
            chatId: widget.chatId,
            usersendId: chatOperation.firebaseService.getFirebaseUserId(),
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}
