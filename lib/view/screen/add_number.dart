import 'package:cabels/controller/add_number_controller.dart';
import 'package:cabels/data/model/cable_model.dart';
import 'package:cabels/view/widgets/HomePage/custom_input.dart';
import 'package:cabels/view/widgets/HomePage/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNumber extends StatelessWidget {
  final CableModel? editCableModel;
  const AddNumber({super.key, this.editCableModel});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNumberController());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments == null ? "أضافة رقم جديد" : "تعديل رقم"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: Get.height -
                  Get.statusBarHeight -
                  Get.bottomBarHeight -
                  AppBar().preferredSize.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomInput(
                    hint: "الاسم",
                    mycontroller: controller.name,
                    focusDirection: "right",
                    isText: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                            hint: "مكان المقسم",
                            mycontroller: controller.location,
                            focusDirection: "right",
                            isText: true),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomInput(
                        hint: "الرقم",
                        mycontroller: controller.number,
                        focusDirection: "left",
                      )),
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomInput(
                          hint: "نوع البوابة",
                          mycontroller: controller.gateType,
                          focusDirection: "left",
                          isText: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInput(
                          hint: "رقم البوابة",
                          mycontroller: controller.gateNumber,
                          focusDirection: "right",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Expanded(
                        child: CustomInput(
                          hint: "الكبين",
                          mycontroller: controller.tank,
                          focusDirection: "right",
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                          child: CustomInput(
                        hint: "كبل",
                        mycontroller: controller.mainCable,
                        focusDirection: "left",
                      )),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: CustomInput(
                          hint: "المنفذ",
                          mycontroller: controller.port,
                          focusDirection: "left",
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: CustomInput(
                          hint: "القائم",
                          mycontroller: controller.qaem,
                          focusDirection: "left",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          hint: "توسط",
                          mycontroller: controller.house,
                          isText: true,
                          focusDirection: "done",
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                          child: CustomInput(
                        hint: "ترمنل",
                        mycontroller: controller.terminal,
                        focusDirection: "left",
                      )),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: CustomInput(
                          hint: "العلبة",
                          mycontroller: controller.box,
                          focusDirection: "left",
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: CustomInput(
                          hint: "رئيسي",
                          mycontroller: controller.cable,
                          focusDirection: "left",
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      child: MyIconButton(
                        icon: Icons.add_box_rounded,
                        str: Get.arguments == null ? "أضافة" : "تعديل",
                        receiveedColors: true,
                        sharePage: true,
                        function: () {
                          if (Get.arguments == null) {
                            controller.insertNewData();
                          } else {
                            controller.editData();
                          }
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
