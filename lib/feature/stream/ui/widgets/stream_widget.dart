import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class StreamWidget extends StatelessWidget {
  const StreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Main image as the background
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
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
                              child: Image.network(
                                "https://randomuser.me/api/portraits/men/32.jpg",
                                width: 35.w,
                                height: 35.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            AppSize.width(10),

                            // Title
                            Expanded(
                              child: Text(
                                "Stream Title Example",
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