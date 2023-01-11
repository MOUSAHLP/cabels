import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/view/widgets/HomePage/add_number_widget.dart';
import 'package:cabels/view/widgets/HomePage/my_cards.dart';
import 'package:cabels/view/widgets/HomePage/my_filters.dart';
import 'package:cabels/view/widgets/HomePage/my_subtitle.dart';
import 'package:cabels/view/widgets/HomePage/search_widget.dart';
import 'package:cabels/view/widgets/HomePage/show_all_button.dart';
import 'package:cabels/view/widgets/main_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            const Maintitle(title: "الصفحة الرئيسية"),
            const AddNumberWidget(),
            const MySubtitle(str: "البحث"),
            const SearchWidget(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShowAllButton(),
                MySubtitle(str: "الأرقام"),
              ],
            ),
            const MyFilters(),
            MyCards(),
            if (MyPlatform.isAndroid)
              const SizedBox(
                height: 13,
              )
          ],
        ),
      ),
    );
  }
}
