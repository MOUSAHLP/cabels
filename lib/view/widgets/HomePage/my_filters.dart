import 'package:cabels/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFilters extends StatelessWidget {
  const MyFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: GetBuilder<HomePageController>(builder: ((controller) {
            return Row(
              children: [
                ...List.generate(controller.filters.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Get.theme.backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding:
                                      const EdgeInsets.only(top: 2, right: 2),
                                  child: const Icon(
                                    Icons.close,
                                    size: 15,
                                  ),
                                ),
                                onTap: () {
                                  controller.deleteFilter(controller
                                          .filters.keys
                                          .toList()[
                                      controller.filters.length - index - 1]);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  " ${controller.filters[controller.filters.keys.toList()[controller.filters.length - index - 1]].text} ",
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(
                                          color: Get.theme.primaryColor,
                                          fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          " ${controller.filters.keys.toList()[controller.filters.length - index - 1]} ",
                          style: Get.theme.textTheme.bodyText2!
                              .copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  );
                })
              ],
            );
          }))),
    );
  }
}
