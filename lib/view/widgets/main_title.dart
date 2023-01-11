import 'package:cabels/core/services/my_platform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Maintitle extends StatelessWidget {
  final String title;
  const Maintitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MyPlatform.isAndroid
        ? CustomPaint(
            size: Size(Get.width, (Get.width * 0.5833333333333334).toDouble()),
            painter: RPSCustomPainter(),
            child: Container(
              width: Get.width,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.headline1!
                    .copyWith(fontSize: 22, color: Colors.white),
              ),
            ),
          )
        : Container();
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Get.theme.primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 1.0065083, size.height * 0.7077000,
        size.width * 0.4991667, size.height * 0.7142857);
    path0.quadraticBezierTo(
        size.width * 0.0022167, size.height * 0.7038857, 0, size.height);
    path0.lineTo(0, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
