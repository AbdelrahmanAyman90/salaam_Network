import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halqahquran/core/status/circuler_image_shimmer.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final ValueChanged<File> onImagePicked;
  final String imageName;
  const ImagePickerWidget({
    Key? key,
    required this.selectedImage,
    required this.onImagePicked,
    required this.imageName,
  }) : super(key: key);

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImagePicked(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => pickImage(context),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 1.0,
              maxScale: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primeColor,
                      AppColor.primeColor.withOpacity(.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    radius: 67,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : CachedNetworkImageProvider(
                            imageName,
                          ) as ImageProvider,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => pickImage(context),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.primeColor, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
