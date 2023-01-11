import 'package:cabels/controller/client_controller.dart';
import 'package:cabels/core/constant/my_assets.dart';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/view/widgets/HomePage/my_icon_button.dart';
import 'package:cabels/view/widgets/share/recieved_data_page.dart';
import 'package:cabels/view/widgets/share/founded_devices_list.dart';
import 'package:cabels/view/widgets/share/waiting-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class MyClient extends StatelessWidget {
  const MyClient({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ClientController());
    return Scaffold(
      appBar: AppBar(title: Text("أستقبال")),
      body: GetBuilder<ClientController>(
        builder: (controller) {
          if (!controller.didSearch) {
            return WaitingPage(
              str1: 'يجب الان على المرسل ان يضغط على ',
              str2: r'" أرسال "',
              lottie: MyAssets.receiving,
              downWidget: Column(
                children: [
                  if (MyPlatform.isWindows)
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Get.theme.primaryColor,
                            value: controller.progress.value,
                            backgroundColor: Get.theme.backgroundColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${((controller.progress.value) * 100).toStringAsFixed(2)} % ",
                            style: Get.textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  Text(
                    "... جاري البحث عن مرسلين",
                    style: Get.theme.textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            if (controller.foundedDevices.isEmpty) {
              return WaitingPage(
                str1: 'لم يتم العثور على',
                str2: " مرسلين ",
                lottie: MyAssets.notFound,
                downWidget: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Resize(
                      builder: () => Container(
                        width: 250.w,
                        child: MyIconButton(
                          icon: Icons.refresh,
                          str: "اعادة المحاولة",
                          receiveedColors: true,
                          sharePage: true,
                          function: () {
                            controller.discoverAllPings();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return !controller.startConnection
                  ? FoundedDivecesList()
                  : RecievedDataPage();
            }
          }
        },
      ),
    );
  }
}
