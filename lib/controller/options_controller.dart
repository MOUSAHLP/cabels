import 'dart:convert';
import 'dart:io';
import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/core/functions/mysnackbar.dart';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/core/services/storage_service.dart';
import 'package:cabels/data/dataSource/local_database.dart';
import 'package:cabels/data/model/cable_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class OptionsController extends GetxController {
  bool isdark = false;
  final homePageController = Get.find<HomePageController>();
  DatabaseHelper db = DatabaseHelper.instance;
  MyServices shared = Get.find();
  String fileName = "cablesBackUp.json";

  Future<Directory> getDir() async {
    if (MyPlatform.isAndroid)
      return Directory('/storage/emulated/0/Download/Cables');
    else {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      Directory dir = Directory(appDocDir.path + "/Cabels");

      return dir;
    }
  }

  changeThemeMode() async {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      shared.sharedPreferences.setBool("isDark", false);
      isdark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      shared.sharedPreferences.setBool("isDark", true);
      isdark = true;
    }
    update();
  }

  clearAllData() {
    Get.defaultDialog(
        title: "هل أنت متأكد",
        titleStyle: Get.theme.textTheme.bodyText1!
            .copyWith(color: Colors.red, fontSize: 20),
        middleText: "سيتم حذف جميع البيانات كلها نهائيا",
        middleTextStyle: Get.theme.textTheme.bodyText1,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  db.clearTable();
                  homePageController.numbers.clear();
                  homePageController.isOpen.clear();
                  homePageController.filters.clear();
                  homePageController.update();
                  Get.back();
                },
                child: const Text("حذف")),
          )
        ]);
  }

  backUp() async {
    List<Map<String, dynamic>> myDataBase = await db.queryAllRows();
    Map<String, dynamic> map = {};
    map["data"] = myDataBase;

    var per = await Permission.storage.status;
    if (per.isGranted) {
      Directory dir = await getDir();

      if (!await dir.exists()) {
        await dir.create();
      }
      File file = File(dir.path + "/" + fileName);

      if (await file.exists()) {
        await file.delete();
      }
      await createFile(map, dir, fileName);

      String savePath = MyPlatform.isAndroid
          ? "في المسار التالي \n Download => Cables =>$fileName"
          : "في المسار التالي \n Documents => Cables =>$fileName";
      mySnackBar("تم عمل نسخة احتياطية ", savePath);
    } else {
      var req = await Permission.storage.request();
      if (req.isGranted) {
        backUp();
      }
    }
  }

  importFile(context) async {
    var per = await Permission.storage.status;
    if (per.isGranted) {
      String? path = await pickFile();

      if (path != null) {
        File file = File(path);

        if (file.path.contains("json") && await file.exists()) {
          Map<String, dynamic> jsonFileContent =
              json.decode(await file.readAsString());

          for (int i = 0; i < jsonFileContent["data"].length; i++) {
            List<Map<String, dynamic>> myData = await db.queryAllRows(where: '''
        name = "${jsonFileContent["data"][i]["name"]}" AND
        location = "${jsonFileContent["data"][i]["location"]}" AND
        gateType = "${jsonFileContent["data"][i]["gateType"]}" AND
        gateNumber = ${jsonFileContent["data"][i]["gateNumber"]} AND
        qaem = ${jsonFileContent["data"][i]["qaem"]} AND
        port = ${jsonFileContent["data"][i]["port"]} AND
        mainCable = ${jsonFileContent["data"][i]["mainCable"]} AND
        tank = ${jsonFileContent["data"][i]["tank"]} AND
        cable = ${jsonFileContent["data"][i]["cable"]} AND
        box = ${jsonFileContent["data"][i]["box"]} AND
        terminal = ${jsonFileContent["data"][i]["terminal"]} AND
        house = "${jsonFileContent["data"][i]["house"]}"
      ''');
            if (myData.isEmpty) {
              print("isempty");
              jsonFileContent["data"][i]["id"] = null;
              await db.insert(CableModel.fromJson(jsonFileContent["data"][i]));
            }
          }
          mySnackBar("نجاح", "تم اضافة البيانات بنجاح");
          homePageController.getAllNumbers();
          homePageController.numbers.clear();
          homePageController.isOpen.clear();
          homePageController.filters.clear();
          homePageController.update();
        } else {
          mySnackBar("خطأ", "صيغة خاطئة");
        }
      }
    } else {
      var req = await Permission.storage.request();
      if (req.isGranted) {
        importFile(context);
      }
    }
  }

  Future<void> createFile(
      Map<String, dynamic> content, Directory dir, String fileName) async {
    File file = new File(dir.path + "/" + fileName);
    await file.create();
    await file.writeAsString(json.encode(content));
  }

  shareData() async {
    var per = await Permission.storage.status;
    if (per.isGranted) {
      Directory dir = await getDir();

      File file = File(dir.path + "/" + fileName);
      if (await file.exists()) {
        Share.shareXFiles([XFile(dir.path + "/" + fileName)],
            text: 'Great picture');
      } else {
        await backUp();
        await shareData();
      }
    } else {
      var req = await Permission.storage.request();
      if (req.isGranted) {
        await shareData();
      }
    }
  }

  Future<String?> pickFile() async {
    if (MyPlatform.isAndroid) {
      Directory dir = Directory('/storage/emulated/0');
      String? path = await FilesystemPicker.open(
        title: "أختر ملف النسخ الاحتياطي",
        folderIconColor: Get.theme.backgroundColor,
        rootName: dir.path,
        context: Get.context!,
        rootDirectory: dir,
        fsType: FilesystemType.file,
        allowedExtensions: ['.json'],
        fileTileSelectMode: FileTileSelectMode.checkButton,
      );
      return path!;
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["json"],
      );

      if (result != null) {
        return result.files.single.path!;
      }
    }
    return null;
  }
}
