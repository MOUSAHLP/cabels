import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/view/screen/home_page.dart';
import 'package:cabels/view/screen/options.dart';
import 'package:cabels/view/screen/share_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  int page = MyPlatform.isAndroid ? 1 : 0;
  String title = "الصفحة الرئيسية";
  List<Widget> screens = const [ShareData(), MyHomePage(), Options()];
  List<Widget> icons = [
    Icon(
      Icons.compare_arrows,
      size: 30,
      color: Get.theme.scaffoldBackgroundColor,
    ),
    Icon(
      Icons.home_outlined,
      size: 30,
      color: Get.theme.scaffoldBackgroundColor,
    ),
    Icon(
      Icons.settings,
      size: 30,
      color: Get.theme.scaffoldBackgroundColor,
    ),
  ];

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  PageController pageController = PageController(initialPage: 1);

  changePage(int index) {
    page = index;
    if (MyPlatform.isAndroid) {
      pageController.jumpToPage(
        page,
      );
    }
    FocusScope.of(Get.context!).unfocus();
    changeTitle();
    update();
  }

  changeIconColors(color) {
    icons = [
      Icon(
        Icons.compare_arrows,
        size: 30,
        color: color,
      ),
      Icon(
        Icons.home_outlined,
        size: 30,
        color: color,
      ),
      Icon(
        Icons.settings,
        size: 30,
        color: color,
      ),
    ];
  }

  changeTitle() {
    if (page == 0) {
      title = "الصفحة الرئيسية";
    }
    if (page == 1) {
      title = "مشاركة البيانات";
    }
    if (page == 2) {
      title = "الاعدادات";
    }
  }
}
