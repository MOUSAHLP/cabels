import 'package:cabels/controller/options_controller.dart';
import 'package:cabels/view/widgets/main_title.dart';
import 'package:cabels/view/widgets/options/aboutus.dart';
import 'package:cabels/view/widgets/options/my_listt_ile.dart';
import 'package:cabels/view/widgets/options/dark_Mode_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OptionsController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: ListView(
          children: [
            Maintitle(title: "الاعدادات"),
            DarkModeSwitch(),
            MyListTile(
              str: "نسخ احتياطي",
              function: () {
                controller.backUp();
              },
            ),
            MyListTile(
              str: "تصدير البيانات",
              function: () {
                controller.shareData();
              },
            ),
            MyListTile(
              str: "استيراد بيانات",
              function: () {
                controller.importFile(context);
              },
            ),
            MyListTile(
              str: "مسح جميع البيانات",
              function: () {
                controller.clearAllData();
              },
            ),
            Aboutus(),
          ],
        ),
      ),
    );
  }
}
