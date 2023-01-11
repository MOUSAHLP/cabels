import 'package:cabels/controller/options_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OptionsController>(
      builder: (controller) {
        return Align(
            alignment: Alignment.center,
            child: Resize(
              builder: () => Container(
                width: Get.width > 1007 ? 200.w : 300.w,
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  value: controller.isdark,
                  onChanged: (value) {
                    controller.changeThemeMode();
                  },
                  tileColor: Get.theme.primaryColor,
                  title: Text(
                    controller.isdark ? "الوضع الداكن" : "الوضع الفاتح",
                    style: Get.theme.textTheme.bodyText1!
                        .copyWith(color: context.theme.backgroundColor),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
