import 'package:cabels/view/widgets/HomePage/detail_text.dart';
import 'package:cabels/view/widgets/HomePage/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCardAndroid extends StatelessWidget {
  final controller;
  final bool withButtons;

  const MyCardAndroid({
    super.key,
    required this.controller,
    this.withButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.numbers.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            controller.openData(i);
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Get.theme.backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Get.theme.primaryColor,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${controller.numbers[i].number} - ${controller.numbers[i].name}",
                            style: Get.theme.textTheme.bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "${controller.numbers[i].location}",
                            style: Get.theme.textTheme.bodyText2!
                                .copyWith(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: double.infinity,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      height: controller.isOpen[i] ? null : 0,
                      // ignore: deprecated_member_use
                      color: Get.theme.accentColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: DetailText(
                                    value: "${controller.numbers[i].gateType}",
                                    text: "نوع البوابة"),
                              ),
                              Expanded(
                                flex: 2,
                                child: DetailText(
                                    value:
                                        "${controller.numbers[i].gateNumber}",
                                    text: "رقم البوابة"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DetailText(
                                  value: "${controller.numbers[i].qaem}",
                                  text: "القائم"),
                              DetailText(
                                  value: "${controller.numbers[i].port}",
                                  text: "المنفذ"),
                              DetailText(
                                  value: "${controller.numbers[i].mainCable}",
                                  text: "كبل"),
                              DetailText(
                                  value: "${controller.numbers[i].tank}",
                                  text: "كبين"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DetailText(
                                  value: "${controller.numbers[i].cable}",
                                  text: "رئيسي"),
                              DetailText(
                                  value: "${controller.numbers[i].box}",
                                  text: "العلبة"),
                              DetailText(
                                  value: "${controller.numbers[i].terminal}",
                                  text: "ترمنل"),
                              DetailText(
                                  value: "${controller.numbers[i].house}",
                                  text: "توسط"),
                            ],
                          ),
                          if (withButtons)
                            const SizedBox(
                              height: 10,
                            ),
                          if (withButtons)
                            Row(
                              children: [
                                Expanded(
                                    child: MyIconButton(
                                        str: "حذف",
                                        icon: Icons.delete,
                                        function: () {
                                          controller.deleteData(
                                              i, controller.numbers[i].id!);
                                        })),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MyIconButton(
                                      str: "تعديل",
                                      icon: Icons.edit,
                                      function: () {
                                        controller
                                            .updateData(controller.numbers[i]);
                                      }),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
