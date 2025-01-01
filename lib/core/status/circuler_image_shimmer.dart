import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCirculerImage extends StatelessWidget {
  const ShimmerCirculerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}
