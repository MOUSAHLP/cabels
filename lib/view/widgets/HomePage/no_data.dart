import 'package:cabels/core/constant/my_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Lottie.asset(
            MyAssets.noData,
          ),
        ),
        Text("لا يوجد بيانات", style: Get.theme.textTheme.headline1)
      ],
    );
  }
}
