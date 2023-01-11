import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class MyListTile extends StatelessWidget {
  final String str;
  final Function()? function;
  const MyListTile({super.key, required this.str, this.function});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Resize(builder: () {
        return Container(
          width: Get.width > 1007 ? 200.w : 300.w,
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: function,
            title: Text(
              str,
              style: Get.theme.textTheme.bodyText1!
                  .copyWith(color: context.theme.backgroundColor),
            ),
          ),
        );
      }),
    );
  }
}
