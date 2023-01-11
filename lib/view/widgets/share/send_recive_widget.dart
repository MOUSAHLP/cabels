import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendReciveWidget extends StatelessWidget {
  final String str1;
  final String str2;
  const SendReciveWidget({super.key, required this.str1, required this.str2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          str1,
          style: Get.theme.textTheme.bodyText1!.copyWith(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20),
        ),
        Text(
          str2,
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.bodyText1!.copyWith(fontSize: 24),
        ),
      ],
    );
  }
}
