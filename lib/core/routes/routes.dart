import 'package:cabels/core/middleware/my_middleware.dart';
import 'package:cabels/data/model/cable_model.dart';
import 'package:cabels/view/first_page.dart';
import 'package:cabels/view/screen/add_number.dart';
import 'package:cabels/view/screen/main_screen.dart';
import 'package:cabels/view/screen/my_client.dart';
import 'package:cabels/view/screen/my_server.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String firstPage = "/";
  static const String mainPage = "/mainPage";
  static const String addNumber = "/AddNumber";
  static const String updateNumber = "/AddNumber";
  static const String serverPage = "/serverPage";
  static const String clientPage = "/clientPage";
}

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: AppRoute.firstPage,
      page: () => const FirstPage(),
      middlewares: [
        MyMiddleWare(),
      ]),
  GetPage(
    name: AppRoute.mainPage,
    page: () => MainScreen(),
  ),
  GetPage(
    name: AppRoute.addNumber,
    page: () => const AddNumber(),
  ),
  GetPage(
      name: AppRoute.updateNumber,
      page: () => const AddNumber(),
      arguments: CableModel),
  GetPage(name: AppRoute.serverPage, page: () => const MyServer()),
  GetPage(name: AppRoute.clientPage, page: () => const MyClient()),
];

// class MyMiddleWare extends GetMiddleware {
//   @override
//   int? get priority => 1;

//   MyServices myServices = Get.find();

//   @override
//   RouteSettings? redirect(String? route) {
//     if (myServices.sharedPreferences.getString("step") == "2") {
//       return const RouteSettings(name: AppRoute.homepage);
//     }
//     if (myServices.sharedPreferences.getString("step") == "1") {
//       return const RouteSettings(name: AppRoute.login);
//     }

//     return null;
//   }
// }
