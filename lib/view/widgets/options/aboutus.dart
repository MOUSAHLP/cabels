import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    double fontResponsive = Get.width > 400 ? 16 : 12;
    return Align(
      alignment: Alignment.center,
      child: Resize(
          builder: (() => Container(
                width: Get.width > 1007 ? 200.w : 300.w,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Get.theme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ": فكرة",
                      style: Get.theme.textTheme.bodyText1!.copyWith(
                        color: Get.theme.backgroundColor,
                        fontSize: fontResponsive + 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "مؤنس الجمعات",
                            style: Get.theme.textTheme.bodyText1!.copyWith(
                              color: Get.theme.backgroundColor,
                              fontSize: fontResponsive,
                            ),
                          ),
                          Text(
                            "نور الدين الجمعات",
                            style: Get.theme.textTheme.bodyText1!.copyWith(
                              color: Get.theme.backgroundColor,
                              fontSize: fontResponsive,
                            ),
                          ),
                          Text(
                            "وجيه الجمعات",
                            style: Get.theme.textTheme.bodyText1!.copyWith(
                              color: Get.theme.backgroundColor,
                              fontSize: fontResponsive,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      ": تم انشاء هذا التطبيق بواسطة",
                      style: Get.theme.textTheme.bodyText1!.copyWith(
                        color: Get.theme.backgroundColor,
                        fontSize: fontResponsive + 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Mousa Al-Halabi",
                            style: Get.theme.textTheme.bodyText1!.copyWith(
                              color: Get.theme.backgroundColor,
                              fontSize: fontResponsive,
                            ),
                          ),
                          Text(
                            "Issa Al-Halabi",
                            style: Get.theme.textTheme.bodyText1!.copyWith(
                              color: Get.theme.backgroundColor,
                              fontSize: fontResponsive,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        ": للتواصل",
                        style: Get.theme.textTheme.bodyText1!.copyWith(
                          color: Get.theme.backgroundColor,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SelectableText(
                          "0946649532",
                          style: Get.theme.textTheme.bodyText1!.copyWith(
                            color: Get.theme.backgroundColor,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final url = Uri.parse(
                                "https://www.facebook.com/esaamousa.halapi?mibextid=ZbWKwL");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.facebook_rounded,
                              color: Color.fromARGB(255, 0, 0, 255),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}
