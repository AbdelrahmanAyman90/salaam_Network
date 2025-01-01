import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/ui/views/audience_stream_page.dart';
import 'package:shimmer/shimmer.dart';

class StreamWidget extends StatelessWidget {
  const StreamWidget({super.key, required this.streamData});
  final StreamModel streamData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AudienceStreamPage(
        //       streamModel: streamData,
        //     ),
        //   ),
        // );
        Navigator.pushNamed(context, AudienceStreamPage.routeName,
            arguments: streamData);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Main image as the background

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: streamData.streamImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey[300],
                ),
              ), // Shimmer effect while loading
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 50,
                ),
              ), // Fallback if image fails to load
            ),
          ),

          // Overlay content
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User circular image
                ClipOval(
                  child: streamData.hostUserImage != null
                      ? Image.network(
                          streamData.hostUserImage ?? " ",
                          width: 35.w,
                          height: 35.h,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primeColor,
                          ),
                          child: Center(
                            child: Text(
                              streamData.hostUserName.substring(0, 1),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                ),
                AppSize.width(10),

                // Title
                Expanded(
                  child: Text(
                    streamData.streamName,
                    textDirection: TextDirection.ltr,
                    style: TextStyles.bold18.copyWith(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.9),
                          offset: const Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
