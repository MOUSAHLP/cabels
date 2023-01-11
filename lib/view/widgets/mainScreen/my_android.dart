import 'package:cabels/controller/main_screen_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAndroid extends StatelessWidget {
  const MyAndroid({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();
    return Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        bottomNavigationBar: GetBuilder<MainScreenController>(
          builder: (controller) => CurvedNavigationBar(
            height: 50,
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            color: Get.theme.primaryColor,
            key: controller.bottomNavigationKey,
            index: controller.page,
            items: controller.icons,
            onTap: controller.changePage,
          ),
        ),
        body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.changePage,
          children: controller.screens,
        ));
  }
}
