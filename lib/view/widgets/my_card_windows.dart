import 'package:cabels/view/widgets/HomePage/detail_text.dart';
import 'package:cabels/view/widgets/HomePage/my_icon_button.dart';
import 'package:cabels/view/widgets/my_card_android.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class MyCardWindows extends StatelessWidget {
  final controller;
  final bool withButtons;

  const MyCardWindows({
    super.key,
    required this.controller,
    this.withButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    return Resize(
      builder: () {
        int columnCount = Get.width ~/ 306;
        double aspectRatio = 10 / 11;

        if (columnCount == 3) {
          aspectRatio = 14 / 16;
        }
        if (columnCount >= 4) {
          columnCount = 4;
          aspectRatio = 15 / 18;
        }
        if (columnCount > 1)
          return GridView.builder(
            shrinkWrap: true,
            itemCount: controller.numbers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, i) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(3),
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
                                style: Get.theme.textTheme.bodyText2!.copyWith(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: Container(
                        // ignore: deprecated_member_use
                        color: Get.theme.accentColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: DetailText(
                                      value:
                                          "${controller.numbers[i].gateType}",
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
                                          controller.updateData(
                                              controller.numbers[i]);
                                        }),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        return Align(
          alignment: Alignment.center,
          child: Resize(
            builder: () => Container(
              width: 300.w,
              child: MyCardAndroid(
                controller: controller,
                withButtons: withButtons,
              ),
            ),
          ),
        );
      },
    );
  }
}
