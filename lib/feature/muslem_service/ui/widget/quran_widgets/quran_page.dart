import 'dart:developer';
import 'package:flutter/material.dart';

class QuranImageScreen extends StatefulWidget {
  final String n;

  const QuranImageScreen({super.key, required this.n});

  @override
  _QuranImageScreenState createState() => _QuranImageScreenState();
}

class _QuranImageScreenState extends State<QuranImageScreen> {
  late PageController _pageController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = int.parse(widget.n);
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: PageView.builder(
              controller: _pageController,
              itemCount: 604, // Adjust if you have fewer pages
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return QuranRasterImage(
                  imagePath:
                      'assets/images/quran_images_new_2/${index + 1}.png',
                );
              },
            ),
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
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill, // Make the image cover the entire screen
        ),
      ),
    );
  }
}
