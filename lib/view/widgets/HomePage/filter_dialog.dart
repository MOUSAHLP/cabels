import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/view/widgets/HomePage/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: ListView(
        primary: true,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "بحث متقدم",
              style: Get.theme.textTheme.headline1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "الاسم",
                    isText: true,
                    mycontroller: controller.nameFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "مكان المقسم",
                    mycontroller: controller.locationFilter,
                    focusDirection: "right",
                    isText: true,
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "نوع البوابة",
                    isText: true,
                    mycontroller: controller.gateTypeFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "رقم البوابة",
                    mycontroller: controller.gateNumberFilter,
                    focusDirection: "right",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "القائم",
                    mycontroller: controller.qaemFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "المنفذ",
                    mycontroller: controller.portFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "كبل",
                    mycontroller: controller.mainCableFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "كبين",
                    mycontroller: controller.tankFilter,
                    focusDirection: "right",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "توسط",
                    mycontroller: controller.houseFilter,
                    focusDirection: "done",
                    isText: true,
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "ترمنل",
                    mycontroller: controller.terminalFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "العلبة",
                    mycontroller: controller.boxFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomInput(
                    hint: "رئيسي",
                    mycontroller: controller.cableFilter,
                    focusDirection: "left",
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
