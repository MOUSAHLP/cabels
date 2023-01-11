import 'package:cabels/core/functions/mysnackbar.dart';
import 'package:cabels/core/routes/routes.dart';
import 'package:cabels/data/dataSource/local_database.dart';
import 'package:cabels/data/model/cable_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  DatabaseHelper db = DatabaseHelper.instance;
  List<CableModel> numbers = [];
  List<bool> isOpen = [];
  Map filters = {};

  TextEditingController nameFilter = TextEditingController();
  TextEditingController locationFilter = TextEditingController();
  TextEditingController numberFilter = TextEditingController();
  TextEditingController gateTypeFilter = TextEditingController();
  TextEditingController gateNumberFilter = TextEditingController();
  TextEditingController qaemFilter = TextEditingController();
  TextEditingController portFilter = TextEditingController();
  TextEditingController mainCableFilter = TextEditingController();
  TextEditingController tankFilter = TextEditingController();
  TextEditingController cableFilter = TextEditingController();
  TextEditingController boxFilter = TextEditingController();
  TextEditingController terminalFilter = TextEditingController();
  TextEditingController houseFilter = TextEditingController();

  @override
  void onInit() {
    getAllNumbers();
    super.onInit();
  }

  void goToAddNumberPage() {
    Get.toNamed(AppRoute.addNumber)!.then((value) => update());
  }

  void getAllNumbers() async {
    numbers.clear();
    isOpen.clear();
    var res = await db.queryAllRows();
    for (int i = 0; i < res.length; i++) {
      numbers.add(CableModel.fromJson(res[i]));
      isOpen.add(false);
    }
    update();
  }

  void openData(index) {
    isOpen[index] = !isOpen[index];
    update();
  }

  void updateData(CableModel cableModel) async {
    Get.toNamed(AppRoute.updateNumber, arguments: cableModel)!.then((value) {
      if (value != null) {
        mySnackBar("نجاح", "تم تعديل الرقم بنجاح", icon: Icons.done);
        update();
      }
    });
  }

  void deleteData(int index, int id) async {
    int isDeleted = await db.delete(id);
    if (isDeleted == 1) {
      numbers.removeAt(index);
      isOpen.removeAt(index);
      mySnackBar("نجاح", "تم حذف الرقم بنجاح", icon: Icons.done);
    }
    update();
  }

  search() async {
    List<Map<String, Object?>> res = await db.filter(
      number: numberFilter.text,
      name: nameFilter.text,
      location: locationFilter.text,
      gateType: gateTypeFilter.text,
      gateNumber: gateNumberFilter.text,
      qaem: qaemFilter.text,
      port: portFilter.text,
      mainCable: mainCableFilter.text,
      tank: tankFilter.text,
      cable: cableFilter.text,
      box: boxFilter.text,
      terminal: terminalFilter.text,
      house: houseFilter.text,
    );
    print(res);
    numbers.clear();
    isOpen.clear();
    for (int i = 0; i < res.length; i++) {
      numbers.add(CableModel.fromJson(res[i]));
      isOpen.add(false);
    }
    changeFilters();
    update();
  }

  changeFilters() {
    filters.clear();
    if (nameFilter.text != "") {
      filters["الاسم"] = nameFilter;
    }
    if (locationFilter.text != "") {
      filters["مكان المقسم"] = locationFilter;
    }
    if (gateTypeFilter.text != "") {
      filters["نوع البوابة"] = gateTypeFilter;
    }
    if (gateNumberFilter.text != "") {
      filters["رقم البوابة"] = gateNumberFilter;
    }
    if (qaemFilter.text != "") {
      filters["القائم"] = qaemFilter;
    }
    if (portFilter.text != "") {
      filters["منفذ"] = portFilter;
    }
    if (mainCableFilter.text != "") {
      filters["كبل"] = mainCableFilter;
    }
    if (tankFilter.text != "") {
      filters["كبين"] = tankFilter;
    }
    if (cableFilter.text != "") {
      filters["رئيسي"] = cableFilter;
    }
    if (boxFilter.text != "") {
      filters["رقم العلبة"] = boxFilter;
    }
    if (terminalFilter.text != "") {
      filters["ترمنل"] = terminalFilter;
    }
    if (houseFilter.text != "") {
      filters["تفرعات"] = houseFilter;
    }
  }

  deleteFilter(String key) {
    filters[key].text = "";
    filters.remove(key);
    search();
    update();
  }

  deleteAllFilter() {
    nameFilter.text = "";
    locationFilter.text = "";
    numberFilter.text = "";
    gateTypeFilter.text = "";
    gateNumberFilter.text = "";
    qaemFilter.text = "";
    portFilter.text = "";
    mainCableFilter.text = "";
    tankFilter.text = "";
    cableFilter.text = "";
    boxFilter.text = "";
    terminalFilter.text = "";
    houseFilter.text = "";
    search();
    update();
  }
}
