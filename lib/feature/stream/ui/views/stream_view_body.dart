import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/stream/ui/widgets/stream_widget.dart';
import 'package:halqahquran/feature/stream/ui/widgets/top_bar_stream.dart';

class StreamViewBody extends StatelessWidget {
  const StreamViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        children: [
          //! Top bar
          const TopBarStream(),
          AppSize.hight(10),
          //! List of streams
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8, // Adjust for layout proportions
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const StreamWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
