import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/stream/ui/widgets/bottom_sheet_stream.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TopBarStream extends StatelessWidget {
  const TopBarStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            " بث مباشر",
            style: TextStyles.semiBold26,
          ),
          IconButton(
            onPressed: () async {
              // Show the modal sheet
              WoltModalSheet.show<void>(
                context: context,
                pageListBuilder: (modalSheetContext) {
                  return [
                    WoltModalSheetPage(
                      child: const BottomSheetStream(),
                    ),
                  ];
                },
              );

              // Call the cubit method
            },
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
