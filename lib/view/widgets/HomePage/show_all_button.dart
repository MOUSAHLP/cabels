import 'package:cabels/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextButton(
          onPressed: () {
            controller.deleteAllFilter();
          },
          child: Text(
            "اظهار الكل",
            style: Get.theme.textTheme.bodyText1!.copyWith(
              fontSize: 12,
              color: Colors.orangeAccent,
            ),
          )),
    );
  }
}
