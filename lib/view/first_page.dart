import 'package:cabels/controller/first_page_controller.dart';
import 'package:cabels/core/constant/my_assets.dart';
import 'package:cabels/view/widgets/HomePage/custom_input.dart';
import 'package:cabels/view/widgets/HomePage/my_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FirstPageController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: ListView(
          children: [
            Container(
              height: Get.height - Get.statusBarHeight,
              width: Get.width,
              child: Column(
                children: [
                  CustomPaint(
                    size: Size(
                        Get.width, (Get.width * 0.5833333333333334).toDouble()),
                    painter: RPSCustomPainter(),
                    child: Container(
                      height: Get.height * .3,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "اهلا بك في تطبيق",
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.headline1!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Cabels",
                            style: Get.theme.textTheme.headline1!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MySubtitle(
                    str: "قبل أستعمال التطبيق يرجى ادخال كلمة السر",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomInput(
                      hint: "أدخل كلمة السر",
                      mycontroller: controller.textEditingController,
                      focusDirection: "left",
                      isText: true,
                      function: (p0) {
                        controller.passwordProcess();
                      },
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      MyAssets.appIcon,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "تطبيق لمساعدة في أعمال مقسم الهاتف",
                      style: Get.theme.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    path0.cubicTo(
        size.width * 0.7500000, 0, size.width * 0.7500000, 0, size.width, 0);
    path0.cubicTo(size.width * 1.0049417, size.height * 0.9341714,
        size.width * 0.2044833, size.height * 0.6299714, 0, size.height);
    path0.cubicTo(0, size.height * 0.7500000, 0, size.height * 0.3707143, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
