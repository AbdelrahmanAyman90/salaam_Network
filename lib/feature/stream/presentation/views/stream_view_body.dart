import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halqahquran/core/service/bloc_observ.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:halqahquran/feature/stream/ui/widgets/stream_widget.dart';
import 'package:halqahquran/feature/stream/ui/widgets/top_bar_stream.dart';
import 'package:halqahquran/generated/l10n.dart';

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
            child: StreamBuilder<List<StreamModel>>(
              stream: context.read<StreamCubit>().getStreams(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "لا يوجود بث الان",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8, // Adjust for layout proportions
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return StreamWidget(
                        streamData: snapshot.data![index],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
