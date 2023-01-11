import 'package:cabels/controller/client_controller.dart';
import 'package:cabels/view/widgets/HomePage/my_cards.dart';
import 'package:cabels/view/widgets/HomePage/my_icon_button.dart';
import 'package:cabels/view/widgets/share/send_recive_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecievedDataPage extends StatelessWidget {
  const RecievedDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          SendReciveWidget(
            str1: "تم الاتصال مع",
            str2:
                "${controller.connectedDivecesInfo["name"]} \n ${controller.connectedDivecesInfo["ip"]}",
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تم تلقي ${controller.receivedData.length} أرقام",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(
            height: 5,
          ),
          MyCards(
            expand: 3,
            withButtons: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyIconButton(
                      icon: Icons.data_saver_on_rounded,
                      str: "استبدال",
                      receiveedColors: true,
                      sharePage: true,
                      function: () async {
                        await controller.rePlaceDataBase();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyIconButton(
                      icon: Icons.read_more_rounded,
                      str: "اضافة",
                      receiveedColors: true,
                      sharePage: true,
                      function: () async {
                        await controller.addToDataBase();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
