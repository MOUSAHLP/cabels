import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cabels/controller/home_page_controller.dart';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/data/dataSource/local_database.dart';
import 'package:cabels/data/model/cable_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:get/get.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class ClientController extends GetxController {
  int port = 4567;
  String myIp = "";
  RxDouble progress = 0.0.obs;
  var streamController;
  DatabaseHelper db = DatabaseHelper.instance;
  List<Map> foundedDevices = [];
  List<CableModel> receivedData = [];
  bool didSearch = false;
  bool isDone = false;
  bool startConnection = false;
  Map connectedDivecesInfo = {};
  List<bool> isOpen = [];
  final homePageController = Get.find<HomePageController>();

  @override
  void onInit() {
    if (MyPlatform.isWindows) {
      streamController = StreamSubscription<HostModel>;
    } else {
      streamController = Stream<NetworkAddress>;
    }

    discoverAllPings();
    // connectToTheServer("192.168.1.105");
    super.onInit();
  }

  @override
  void onClose() {
    if (MyPlatform.isWindows) {
      streamController.cancel();
    }
    super.onClose();
  }

  connectToTheServer(String ip) async {
    try {
      final socket = await Socket.connect(ip, port);
      print(
          'Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
      startConnection = true;
      update();
      socket.listen(
        (Uint8List data) {
          final serverResponse = String.fromCharCodes(data);

          Map allData = jsonDecode(utf8.decode(serverResponse.codeUnits));
          if (allData["data"] != null) {
            for (int i = 0; i < allData["data"].length; i++) {
              print('Server + $i : ${CableModel.fromJson(allData["data"][i])}');
              receivedData.add(CableModel.fromJson(allData["data"][i]));
              isOpen.add(false);
            }
            print(receivedData);
          }
        },
        onError: (error) {
          print(error);
          socket.destroy();
        },
        onDone: () {
          print('Server left.');
          isDone = true;
          update();
          socket.destroy();
        },
      );
      String myDeviceName = await getDeviceName();
      sendMessage(socket, {
        "ip": myIp,
        "name": myDeviceName,
        "start": true,
      });
    } catch (e) {
      print(e);
      print("e");
    }
  }

  sendMessage(Socket socket, Map message) {
    socket.write(jsonEncode(message));
  }

  Future<String> getDeviceName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (MyPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.model;
    } else {
      WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;
      return windowsInfo.userName;
    }
  }

  allWifiInfo() async {
    final info = NetworkInfo();
    String? subnet;
    var wifiName = await info.getWifiName(); // "FooNetwork"
    var wifiIP = await info.getWifiIP(); // 192.168.1.43

    if (wifiIP != null && !wifiIP.contains("192")) {
      subnet = replaceArabicNumber(wifiIP);
      myIp = replaceArabicNumber(wifiIP);
      subnet = subnet.substring(0, subnet.lastIndexOf('.'));
    }
    print("wifiName $wifiName");
    print("wifiIP $wifiIP");
    return subnet ?? "192.168.1";
  }

  Future<void> discoverAllPings() async {
    didSearch = false;
    progress.value = 0.0;

    update();
    String subnet = await allWifiInfo();
    if (MyPlatform.isAndroid) {
      streamController = NetworkAnalyzer.discover2(subnet, port);
      streamController.listen((NetworkAddress addr) async {
        if (addr.exists) {
          print('Found device: ${addr.ip}:${port}');
          try {
            final socket = await Socket.connect("${addr.ip}", port,
                timeout: Duration(
                  milliseconds: 50,
                ));
            await socket.listen((response) {
              var res = jsonDecode((String.fromCharCodes(response)));
              print(res);

              if (res["deviceName"] != null) {
                foundedDevices.add({
                  "ip": addr.ip,
                  "name": res["deviceName"],
                  "type": res["type"]
                });
              }
            });
          } catch (e) {
            update();
          }
        }
      }).onDone(() {
        print(foundedDevices);
        progress.value = 0.0;
        didSearch = true;
        print(didSearch);
        update();
      });
    } else {
      final scanner = LanScanner();
      final stream = scanner.icmpScan(subnet, progressCallback: (pr) {
        print('Progress: $pr');
        progress.value = pr;
      });
      streamController = await stream.listen((HostModel device) async {
        print("Found host: ${device.ip}");
        try {
          final socket = await Socket.connect("${device.ip}", port,
              timeout: Duration(
                milliseconds: 50,
              ));
          await socket.listen((response) {
            var res = jsonDecode((String.fromCharCodes(response)));
            print(res);

            if (res["deviceName"] != null) {
              foundedDevices.add({
                "ip": device.ip,
                "name": res["deviceName"],
                "type": res["type"]
              });
            }
          });
        } catch (e) {
          update();
        }
      });
      streamController.onDone(() {
        print(foundedDevices);
        progress.value = 0.0;
        didSearch = true;
        print(didSearch);
        update();
      });
    }

    // print("start");
    // for (var i = 90; i < 120; i++) {
    //   String ip = '$subnet.$i';
    //   print(ip);

    //   await Socket.connect(ip, port, timeout: Duration(milliseconds: 50))
    //       .then((socket) async {
    //     await socket.listen((response) {
    //       var res = jsonDecode((String.fromCharCodes(response)));
    //       print(res);

    //       if (res["deviceName"] != null) {
    //         foundedDevices.add(
    //             {"ip": ip, "name": res["deviceName"], "type": res["type"]});
    //       }
    //     });
    //     socket.destroy();
    //   }).catchError((error) => null);
    // }
  }

  String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  void openData(index) {
    isOpen[index] = !isOpen[index];
    update();
  }

  addToDataBase() async {
    for (int i = 0; i < receivedData.length; i++) {
      List<Map<String, dynamic>> myData = await db.queryAllRows(where: '''
          name = "${receivedData[i].name}" AND
          location = "${receivedData[i].location}" AND
          gateType = "${receivedData[i].gateType}" AND
          gateNumber = ${receivedData[i].gateNumber} AND
          qaem = ${receivedData[i].qaem} AND
          port = ${receivedData[i].port} AND
          mainCable = ${receivedData[i].mainCable} AND
          tank = ${receivedData[i].tank} AND
          cable = ${receivedData[i].cable} AND
          box = ${receivedData[i].box} AND
          terminal = ${receivedData[i].terminal} AND
          house = "${receivedData[i].house}"
        ''');

      if (myData.isEmpty) {
        receivedData[i].id = null;
        await db.insert(receivedData[i]);
      }
    }
    homePageController.getAllNumbers();
    homePageController.filters.clear();
    homePageController.update();
    Get.back();
  }

  rePlaceDataBase() async {
    await db.clearTable();
    await addToDataBase();
  }
}
