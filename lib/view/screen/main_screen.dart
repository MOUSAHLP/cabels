import 'package:cabels/controller/main_screen_controller.dart';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/view/widgets/mainScreen/my_android.dart';
import 'package:cabels/view/widgets/mainScreen/my_windows.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final controller = Get.put(MainScreenController());
  @override
  Widget build(BuildContext context) {
    controller.changeIconColors(context.theme.scaffoldBackgroundColor);
    if (MyPlatform.isAndroid) {
      return MyAndroid();
    }
    return MyWindows();
  }
}
