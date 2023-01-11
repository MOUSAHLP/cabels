import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final String str;
  final bool receiveedColors;
  final bool sharePage;
  final Function()? function;
  const MyIconButton({
    super.key,
    required this.icon,
    required this.str,
    this.function,
    this.receiveedColors = false,
    this.sharePage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Resize(
          builder: () => InkWell(
                onTap: function,
                child: Container(
                  width: sharePage ? 250.w : null,
                  padding: EdgeInsets.symmetric(
                      horizontal: 6, vertical: sharePage ? 14 : 6),
                  decoration: BoxDecoration(
                      color: receiveedColors
                          ? Get.theme.primaryColor
                          : Get.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        icon,
                        size: sharePage && Get.width > 500 ? 30 : 24,
                        color: receiveedColors
                            ? Get.theme.scaffoldBackgroundColor
                            : Get.theme.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        str,
                        style: Get.theme.textTheme.bodyText1!.copyWith(
                          color: receiveedColors
                              ? Get.theme.scaffoldBackgroundColor
                              : Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
