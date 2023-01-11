import 'package:cabels/core/routes/routes.dart';
import 'package:cabels/core/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;

  MyServices myServices = Get.find();

  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getBool("isLogedIn") == true) {
      return const RouteSettings(name: AppRoute.mainPage);
    }
    return null;
  }
}
