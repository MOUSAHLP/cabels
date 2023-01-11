import 'package:cabels/controller/theme_controller.dart';
import 'package:cabels/core/routes/routes.dart';
import 'package:cabels/core/services/storage_service.dart';
import 'package:cabels/core/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  sqfliteFfiInit();
  await initialServices();

  if (defaultTargetPlatform == TargetPlatform.windows) {
    sqfliteFfiInit();
    print(databaseFactory);

    await WindowManager.instance.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: false,
      );
      // await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.center();
      await windowManager.setTitle("Cabels");
      // await windowManager.setIcon("assets\cableIcon.png");
      await windowManager.show();
      // await windowManager.setFullScreen(true);
      // await windowManager.setPreventClose(true);
      // await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeApp().light,
      darkTheme: ThemeApp().dark,
      themeMode: ThemeController().handelThemeGet,
      getPages: routes,
    );
  }
}
