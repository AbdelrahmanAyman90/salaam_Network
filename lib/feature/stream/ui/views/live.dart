import 'package:flutter/material.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';

class live extends StatelessWidget {
  const live({super.key, required this.streamModel});
  final StreamModel streamModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('live'),
      ),
    );
  }
}
