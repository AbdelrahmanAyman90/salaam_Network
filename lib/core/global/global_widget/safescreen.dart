import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

class SafeScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final Drawer? drawer;
  final Widget? bottomNavigationBar;
  SafeScaffold({
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primeColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          appBar: appBar,
          body: Directionality(textDirection: TextDirection.rtl, child: body),
          floatingActionButton: floatingActionButton,
          drawer: drawer,
        ),
      ),
    );
  }
}
