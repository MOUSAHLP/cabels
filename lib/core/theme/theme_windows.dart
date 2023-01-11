import 'package:cabels/core/constant/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ThemeAppWindows {
  get getTheme => ThemeData(
        activeColor: AppColor.primaryColor,
        micaBackgroundColor: AppColor.primaryColor,
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: AppColor.background,
          selectedTextStyle: ButtonState.resolveWith(
            (states) {
              return TextStyle(
                color: AppColor.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              );
            },
          ),
          unselectedTextStyle: ButtonState.resolveWith(
            (states) {
              return TextStyle(
                color: AppColor.textColor,
                fontSize: 14,
              );
            },
          ),
        ),
      );
}
