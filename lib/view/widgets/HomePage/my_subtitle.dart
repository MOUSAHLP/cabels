import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySubtitle extends StatelessWidget {
  final String str;
  const MySubtitle({super.key, required this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      child: Text(
        str,
        style: Get.theme.textTheme.bodyText1!
            // ignore: deprecated_member_use
            .copyWith(color: Get.theme.accentColor, fontSize: 14),
      ),
    );
  }
}
