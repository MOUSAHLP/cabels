import 'package:cabels/controller/server_controller.dart';
import 'package:cabels/core/constant/my_assets.dart';
import 'package:cabels/view/widgets/share/waiting-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyServer extends StatelessWidget {
  const MyServer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServerController());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text("أرسال")),
          body: GetBuilder<ServerController>(
            builder: (controller) {
              return controller.connectedDevice.isEmpty
                  ? WaitingPage(
                      str1: 'يجب الان على المستقبل ان يضغط على ',
                      str2: r'" استقبال "',
                      lottie: MyAssets.loading,
                      downWidget: Text(
                        "... يتم انتظار المستقبل"
                        "\n"
                        "${controller.deviceName} اسم جهازك هو ",
                        style: Get.theme.textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : !controller.dataSended
                      ? WaitingPage(
                          str1:
                              ' تم الاتصال مع  ${controller.connectedDevice["ip"]}',
                          str2: controller.connectedDevice["name"],
                          lottie: MyAssets.receiving,
                          downWidget: Text(
                            "... يتم ارسال البيانات",
                            style: Get.theme.textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : WaitingPage(
                          str1: 'تم أرسال البيانات الى ',
                          str2: controller.connectedDevice["name"],
                          lottie: MyAssets.done,
                          repeat: false,
                          downWidget: Text(
                            " تم مشاركة ${controller.myData.length} ارقام",
                            style: Get.theme.textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                        );
            },
          )),
    );
  }
}
