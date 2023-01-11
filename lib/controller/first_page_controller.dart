import 'package:cabels/core/routes/routes.dart';
import 'package:cabels/core/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirstPageController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  MyServices myServices = Get.find();
  passwordProcess() async {
    String password = "63119688114444AgME";
    if (textEditingController.text.trim() == password) {
      await myServices.sharedPreferences.setBool("isLogedIn", true);
      Get.offAllNamed(AppRoute.mainPage);
    }
  }
}
