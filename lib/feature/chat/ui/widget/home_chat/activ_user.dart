import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivUser extends StatelessWidget {
  const ActivUser({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32.r,
            // backgroundImage: const AssetImage(
            //     'assets/images/istockphoto-1337144146-612x612.jpg'),
            child: Text(name),
          ),
          Positioned(
            right: 0.h,
            bottom: 6.h,
            child: CircleAvatar(
              radius: 6.r,
              backgroundColor: const Color.fromARGB(255, 12, 231, 19),
            ),
          )
        ],
      ),
    );
  }
}
