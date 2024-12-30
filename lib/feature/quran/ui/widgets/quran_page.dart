import 'dart:developer';
import 'package:flutter/material.dart';

class QuranImageScreen extends StatefulWidget {
  final int numberPage;

  const QuranImageScreen({super.key, required this.numberPage});

  @override
  _QuranImageScreenState createState() => _QuranImageScreenState();
}

class _QuranImageScreenState extends State<QuranImageScreen> {
  late PageController _pageController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.numberPage;
    _pageController = PageController(initialPage: currentPage - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page + 1;
      log("Current page: $currentPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: PageView.builder(
            controller: _pageController,
            itemCount: 604, // Adjust if you have fewer pages
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return QuranRasterImage(
                imagePath: 'assets/images/quran_images_new_2/${index + 1}.png',
              );
            },
          ),
        ),
      ),
    );
  }
}

class QuranRasterImage extends StatelessWidget {
  final String imagePath;

  const QuranRasterImage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: InteractiveViewer(
        panEnabled: true, // Enable panning
        scaleEnabled: true, // Enable zooming
        minScale: 1.0, // Minimum zoom scale
        maxScale: 4.0, // Maximum zoom scale
        child: Image(
          image: ResizeImage(
            AssetImage(imagePath),
            width: MediaQuery.of(context).size.width.toInt(),
            height: MediaQuery.of(context).size.height.toInt(),
          ),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.low,
        ),
      ),
    );
  }
}
