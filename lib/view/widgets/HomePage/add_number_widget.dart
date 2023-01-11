import 'package:cabels/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class AddNumberWidget extends StatelessWidget {
  const AddNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return InkWell(
      onTap: () {
        controller.goToAddNumberPage();
      },
      child: Resize(builder: () {
        return Container(
          width: Get.width > 500 ? 200.w : 300.w,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "أضافة رقم جديد",
                      style: Get.theme.textTheme.bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      "أنقر للاضافة",
                      style: Get.theme.textTheme.bodyText2!
                          .copyWith(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Get.theme.backgroundColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.add,
                    color: Get.theme.primaryColor,
                  )),
            ],
          ),
        );
      }),
    );
  }
}
