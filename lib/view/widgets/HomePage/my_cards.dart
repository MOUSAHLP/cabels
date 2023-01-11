import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/view/widgets/HomePage/no_data.dart';
import 'package:cabels/view/widgets/my_card_android.dart';
import 'package:cabels/view/widgets/my_card_windows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCards extends StatelessWidget {
  final int expand;
  final bool withButtons;
  const MyCards({super.key, this.expand = 1, this.withButtons = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (controller) {
      if (controller.numbers.isEmpty) {
        return Expanded(child: const NoData());
      } else {
        if (MyPlatform.isAndroid)
          return Expanded(
            flex: expand,
            child: MyCardAndroid(
              controller: controller,
              withButtons: withButtons,
            ),
          );
        return Expanded(
          flex: expand,
          child: MyCardWindows(
            controller: controller,
            withButtons: withButtons,
          ),
        );
      }
    });
  }
}
