import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailText extends StatelessWidget {
  final String text;
  final value;
  const DetailText({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$value",
          textDirection: TextDirection.rtl,
          style: Get.theme.textTheme.bodyText1!.copyWith(color: Colors.white),
        ),
        Text(
          text,
          textDirection: TextDirection.rtl,
          style: Get.theme.textTheme.bodyText1!
              .copyWith(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}
