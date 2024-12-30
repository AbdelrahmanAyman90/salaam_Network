import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/chat/data/repo/chat_repo_impl.dart';
import 'package:halqahquran/feature/chat/ui/cubit/cubit/chat_cubit.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/bottomsheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TopBarInChatScreen extends StatelessWidget {
  const TopBarInChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
        firebaseService: getIt<FirebaseService>(),
        chatRepoImpl: getIt<ChatRepoImpl>(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "المحادثات",
            style: TextStyles.semiBold26,
          ),
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () async {
                  // Show the modal sheet
                  WoltModalSheet.show<void>(
                    context: context,
                    pageListBuilder: (modalSheetContext) {
                      return [
                        WoltModalSheetPage(
                          child: BlocProvider.value(
                            value: context.read<ChatCubit>(),
                            child: const BottomSheatInChatScree(),
                          ),
                        ),
                      ];
                    },
                  );

                  // Call the cubit method
                  await context.read<ChatCubit>().getAllUser();
                },
                icon: const Icon(
                  Icons.add_circle_outline_outlined,
                  size: 38,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
