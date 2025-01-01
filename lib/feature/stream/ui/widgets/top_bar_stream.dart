import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:halqahquran/feature/stream/ui/widgets/bottom_sheet_stream.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TopBarStream extends StatelessWidget {
  const TopBarStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              context: context, // Use the context of the TopBarStream widget
              pageListBuilder: (modalSheetContext) {
                // modalSheetContext is the context of the modal sheet
                return [
                  WoltModalSheetPage(
                    child: BlocProvider.value(
                      value: context.read<
                          StreamCubit>(), // Provide the existing StreamCubit using the TopBarStream context
                      child: const BottomSheetStream(),
                    ),
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
    );
  }
}
