import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/core/functions/mysnackbar.dart';
import 'package:cabels/core/services/storage_service.dart';
import 'package:cabels/data/dataSource/local_database.dart';
import 'package:cabels/data/model/cable_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNumberController extends GetxController {
  MyServices myServices = Get.find();
  final homeController = Get.find<HomePageController>();
  DatabaseHelper db = DatabaseHelper.instance;
  int? id;

  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController gateType = TextEditingController();
  TextEditingController gateNumber = TextEditingController();
  TextEditingController qaem = TextEditingController();
  TextEditingController port = TextEditingController();
  TextEditingController mainCable = TextEditingController();
  TextEditingController tank = TextEditingController();
  TextEditingController cable = TextEditingController();
  TextEditingController box = TextEditingController();
  TextEditingController terminal = TextEditingController();
  TextEditingController house = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      editMode();
    }
    super.onInit();
  }

  editMode() {
    id = Get.arguments.id;
    name.text = Get.arguments.name;
    location.text = Get.arguments.location;
    number.text = Get.arguments.number.toString();
    gateType.text = Get.arguments.gateType.toString();
    gateNumber.text = Get.arguments.gateNumber.toString();
    qaem.text = Get.arguments.qaem.toString();
    port.text = Get.arguments.port.toString();
    mainCable.text = Get.arguments.mainCable.toString();
    tank.text = Get.arguments.tank.toString();
    cable.text = Get.arguments.cable.toString();
    box.text = Get.arguments.box.toString();
    terminal.text = Get.arguments.terminal.toString();
    house.text = Get.arguments.house.toString();
  }

  editData() async {
    if (name.text != "" &&
        location.text != "" &&
        number.text != "" &&
        gateType.text != "" &&
        gateNumber.text != "" &&
        qaem.text != "" &&
        port.text != "" &&
        mainCable.text != "" &&
        tank.text != "" &&
        cable.text != "" &&
        box.text != "" &&
        terminal.text != "" &&
        house.text != "") {
      CableModel newCable = CableModel(
        id: id,
        name: name.text,
        location: location.text,
        number: int.parse(number.text),
        gateType: gateType.text,
        gateNumber: int.parse(gateNumber.text),
        qaem: int.parse(qaem.text),
        port: int.parse(port.text),
        mainCable: int.parse(mainCable.text),
        tank: int.parse(tank.text),
        cable: int.parse(cable.text),
        box: int.parse(box.text),
        terminal: int.parse(terminal.text),
        house: house.text,
      );
      print("function newCable.toJson()");
      print(newCable.toJson());

      await db.update(newCable, "id = $id");
      int index = homeController.numbers
          .indexWhere((element) => element.id == newCable.id);
      homeController.numbers[index] = newCable;

      Get.back(result: newCable);
    }
  }

  insertNewData() async {
    if (name.text != "" &&
        location.text != "" &&
        number.text != "" &&
        gateType.text != "" &&
        gateNumber.text != "" &&
        qaem.text != "" &&
        port.text != "" &&
        mainCable.text != "" &&
        tank.text != "" &&
        cable.text != "" &&
        box.text != "" &&
        terminal.text != "" &&
        house.text != "") {
      CableModel newCable = CableModel(
          name: name.text,
          location: location.text,
          gateType: gateType.text,
          gateNumber: int.parse(gateNumber.text),
          qaem: int.parse(qaem.text),
          port: int.parse(port.text),
          mainCable: int.parse(mainCable.text),
          tank: int.parse(tank.text),
          cable: int.parse(cable.text),
          box: int.parse(box.text),
          house: house.text,
          terminal: int.parse(terminal.text),
          number: int.parse(number.text));
      await db.insert(newCable);

      homeController.getAllNumbers();

      clearInputs();
      mySnackBar("نجاح", "تم أضافة الرقم", icon: Icons.done);
    } else {
      mySnackBar("خطأ", "يرجى تعبئة جميع الحقول", icon: Icons.close);
    }
  }

  clearInputs() {
    name.text = "";
    location.text = "";
    number.text = "";
    gateType.text = "";
    gateNumber.text = "";
    qaem.text = "";
    port.text = "";
    mainCable.text = "";
    tank.text = "";
    cable.text = "";
    box.text = "";
    terminal.text = "";
    house.text = "";
  }
}
