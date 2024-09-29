import 'dart:math';
import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/util/permission_handelr.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QublaScreen extends StatefulWidget {
  const QublaScreen({super.key});

  @override
  State<QublaScreen> createState() => _QublaScreenState();
}

class _QublaScreenState extends State<QublaScreen>
    with SingleTickerProviderStateMixin {
  final PermissionHandelar permission = PermissionHandelar();
  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: FutureBuilder<bool>(
        future: permission.checkLocationPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return StreamBuilder(
              stream: FlutterQiblah.qiblahStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                final qiblahDirection = snapshot.data;
                animation = Tween(
                        begin: begin,
                        end: (qiblahDirection!.qiblah * (pi / 180) * -1))
                    .animate(_animationController!);
                begin = (qiblahDirection.qiblah * (pi / 180) * -1);
                _animationController!.forward(from: 0);

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${qiblahDirection.direction.toInt()}°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 300,
                        child: AnimatedBuilder(
                          animation: animation!,
                          builder: (context, child) => Transform.rotate(
                            angle: animation!.value,
                            child: Image.asset('assets/images/qibla.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Location permission is required.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      PermissionStatus status =
                          await Permission.location.status;
                      if (status.isPermanentlyDenied) {
                        await openAppSettings();
                      } else {
                        setState(() {});
                      }
                    },
                    child: Text('Request Permission'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
