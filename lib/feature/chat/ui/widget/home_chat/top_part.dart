import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/chat/cubit/cubit/chat_cubit.dart';
import 'package:halqahquran/feature/chat/ui/screen/home_chat_screen.dart';
import 'package:halqahquran/feature/chat/ui/widget/home_chat/bottomsheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TopBarInChatScreen extends StatelessWidget {
  const TopBarInChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "المحادثات",
          style: TextAppStyle.mainTittel.copyWith(color: Colors.black),
        ),
        //!button add
        IconButton(
          onPressed: () async {
            WoltModalSheet.show<void>(
              context: context,
              pageListBuilder: (modalSheetContext) {
                return [
                  WoltModalSheetPage(child: const BottomSheatInChatScree())
                ];
              },
            );

            await context.read<ChatCubit>().getAllUser();
          },
          icon: const Icon(
            Icons.add_circle_outline_outlined,
            color: Colors.black,
            size: 38,
          ),
        ),
      ],
    );
  }
}
