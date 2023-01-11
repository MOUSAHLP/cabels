import 'package:cabels/controller/main_screen_controller.dart';
import 'package:cabels/core/constant/app_colors.dart';
import 'package:cabels/core/theme/theme_windows.dart';
import 'package:cabels/view/screen/home_page.dart';
import 'package:cabels/view/screen/options.dart';
import 'package:cabels/view/screen/share_data.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MyWindows extends StatelessWidget {
  const MyWindows({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        color: AppColor.primaryColor,
        theme: ThemeAppWindows().getTheme,
        debugShowCheckedModeBanner: false,
        home: GetBuilder<MainScreenController>(builder: (controller) {
          return NavigationView(
            appBar: NavigationAppBar(
              leading: Container(),
              title: Text(
                controller.title,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20,
                ),
              ),
            ),
            pane: NavigationPane(
                selected: controller.page,
                onChanged: controller.changePage,
                items: [
                  PaneItem(
                    icon: Icon(FluentIcons.home, size: 20),
                    title: Text("الصفحة الرئيسية"),
                    body: MyHomePage(),
                  ),
                  PaneItem(
                    icon: Icon(FluentIcons.branch_compare, size: 20),
                    title: Text("مشاركة البيانات"),
                    body: ShareData(),
                  ),
                ],
                footerItems: [
                  PaneItem(
                    icon: Icon(FluentIcons.settings, size: 20),
                    title: Text("الاعدادات"),
                    body: Options(),
                  ),
                ]),
          );
        }));
  }
}
