import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BottomSheetStream extends StatefulWidget {
  const BottomSheetStream({super.key});

  @override
  State<BottomSheetStream> createState() => _BottomSheetStreamState();
}

class _BottomSheetStreamState extends State<BottomSheetStream> {
  TextEditingController titelStreamController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? selectedImage; // To store the selected image

  @override
  void dispose() {
    titelStreamController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> validateAndStartStream() async {
    if (formKey.currentState!.validate()) {
      if (selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('من فضلك اختر صورة للبث')),
        );
        return;
      }
      // Proceed to start the stream
      print('Starting stream with title: ${titelStreamController.text}');
      print('Image path: ${selectedImage!.path}');
      await context.read<StreamCubit>().createStream(
            streamName: titelStreamController.text,
            streamImage: selectedImage!.path,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Text(
              "اضافه بث جديد",
              style:
                  TextAppStyle.mainTittel.copyWith(color: AppColor.primeColor),
            ),
            AppSize.hight(10),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: pickImage, // Choose or replace the image
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: AppColor.lightBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          image: selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(selectedImage!.path),
                                  ),
                                  fit: BoxFit.fill,
                                )
                              : null,
                        ),
                        child: selectedImage != null
                            ? null
                            : Icon(
                                Icons.add_a_photo,
                                size: 50.sp,
                                color: AppColor.text,
                              )),
                  ),
                  AppSize.width(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ارفع صوره البث',
                        style: TextStyles.semiBold18,
                      ),
                      AppSize.hight(10),
                      const Text(
                        'اختر صوره من المعرض',
                        style: TextStyles.medium14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSize.hight(20),
            Form(
              key: formKey,
              child: CustomTextField(
                hintText: "عنوان البث",
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل الاسم';
                  }
                  return null;
                },
                controllar: titelStreamController,
              ),
            ),
            AppSize.hight(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: CustomButton(
                onPressed: validateAndStartStream, // Validate and start stream
                widgetButton: Text(
                  "ابدأ البث",
                  style: TextStyles.semiBold18.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
