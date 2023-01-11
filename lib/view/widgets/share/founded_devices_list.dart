import 'package:cabels/controller/client_controller.dart';
import 'package:cabels/view/widgets/share/send_recive_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class FoundedDivecesList extends StatelessWidget {
  const FoundedDivecesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientController>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SendReciveWidget(
            str1: "تم العثور على ${controller.foundedDevices.length} مرسلين",
            str2: "أنقر للاتصال",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.foundedDevices.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 5,
                );
              },
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Resize(
                    builder: () => Container(
                      width: Get.width > 500 ? 200.w : 300.w,
                      child: ListTile(
                        title: Text(
                          "${controller.foundedDevices[index]["name"]}",
                          style: Get.theme.textTheme.headline1!
                              .copyWith(color: Get.theme.backgroundColor),
                        ),
                        subtitle: Text(
                            "IP : ${controller.foundedDevices[index]["ip"]}"),
                        trailing: Icon(
                          controller.foundedDevices[index]["type"] == "computer"
                              ? Icons.computer
                              : Icons.phone_android_rounded,
                          color: Get.theme.backgroundColor,
                          size: 35,
                        ),
                        onTap: () {
                          controller.connectedDivecesInfo = {
                            "ip": controller.foundedDevices[index]["ip"],
                            "name": controller.foundedDevices[index]["name"],
                          };
                          controller.connectToTheServer(
                              controller.foundedDevices[index]["ip"]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
