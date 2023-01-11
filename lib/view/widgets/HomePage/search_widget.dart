import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/view/widgets/HomePage/custom_input.dart';
import 'package:cabels/view/widgets/HomePage/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: Get.theme.primaryColor,
              size: 30,
            ),
            onPressed: () {
              Get.bottomSheet(const FilterDialog());
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Resize(
                builder: () => Container(
                  width: 300.w,
                  child: CustomInput(
                    hint: "أبحث من خلال الرقم",
                    mycontroller: controller.numberFilter,
                    focusDirection: "left",
                    issearch: true,
                    function: (value) {
                      controller.search();
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
