import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/core/util/screen_util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageMassage extends StatelessWidget {
  final String urlMassage;
  final bool isSender;
  final bool seen;
  final String time;
  const ImageMassage({
    super.key,
    required this.isSender,
    required this.urlMassage,
    required this.seen,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSize.hight(10),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
                constraints: BoxConstraints(
                    maxWidth: AppScreenUtil.getResponsiveWidth(context, .6)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: isSender
                    ? const EdgeInsets.only(right: 10)
                    : const EdgeInsets.only(left: 10),
                decoration: isSender
                    ? BoxDecoration(
                        color: AppColor.primeColor.withOpacity(.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                            bottomLeft: Radius.circular(30.r)))
                    : BoxDecoration(
                        color: Colors.grey.withOpacity(.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r))),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     isSender
                    //         ? const SizedBox()
                    //         : Text(
                    //             userNmae,
                    //             style: TextAppStyle.normalTittel.copyWith(
                    //                 color:
                    //                     const Color.fromARGB(255, 7, 67, 135),
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //   ],
                    // ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoViewPage(
                                imageUrl: urlMassage,
                              ),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: urlMassage,
                          imageBuilder: (context, imageProvider) => Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  AppScreenUtil.getResponsiveWidth(context, .6),
                            ),
                            height: 180.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primeColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        )),
                    AppSize.hight(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: TextAppStyle.subTittel.copyWith(fontSize: 14),
                        ),
                        isSender
                            ? Icon(
                                Icons.done_all_outlined,
                                color: seen ? Colors.lightBlue : Colors.grey,
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ],
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  final String imageUrl;
  const PhotoViewPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
