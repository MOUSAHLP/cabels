import 'package:cabels/core/constant/my_assets.dart';
import 'package:cabels/core/functions/mysnackbar.dart';
import 'package:cabels/core/routes/routes.dart';
import 'package:cabels/data/dataSource/local_database.dart';
import 'package:cabels/view/widgets/HomePage/my_icon_button.dart';
import 'package:cabels/view/widgets/main_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ShareData extends StatelessWidget {
  const ShareData({super.key});

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          body: Column(
            children: [
              Maintitle(title: "مشاركة الملفات"),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "هنا يمكنك ارسال و استقبال بيانات\n من أجهزة اخرى من ",
                          style: Get.theme.textTheme.bodyText1!.copyWith(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: " نفس الشبكة",
                          style: Get.theme.textTheme.bodyText1!
                              .copyWith(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Lottie.asset(MyAssets.share),
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
                                icon: Icons.send,
                                str: "أرسال",
                                sharePage: true,
                                receiveedColors: true,
                                function: () async {
                                  DatabaseHelper db =
                                      await DatabaseHelper.instance;
                                  List<Map<String, dynamic>> rows =
                                      await db.queryAllRows();
                                  if (rows.isNotEmpty) {
                                    Get.toNamed(AppRoute.serverPage);
                                  } else {
                                    mySnackBar("ليس لديك أرقام",
                                        "يرجى اضافة بعض الارقام لعملية الارسال");
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MyIconButton(
                                icon: Icons.sim_card_download_outlined,
                                str: "استقبال",
                                receiveedColors: true,
                                sharePage: true,
                                function: () {
                                  Get.toNamed(AppRoute.clientPage);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
