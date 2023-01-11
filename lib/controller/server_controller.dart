import 'dart:convert';
import 'dart:io';
import 'package:cabels/core/services/my_platform.dart';
import 'package:cabels/data/dataSource/local_database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ServerController extends GetxController {
  late ServerSocket server;
  DatabaseHelper db = DatabaseHelper.instance;
  List<Map> myData = [];
  String deviceName = "";
  Map connectedDevice = {};
  bool dataSended = false;

  ini() async {
    deviceName = await getDeviceName();
    update();
    server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
    print("server started");
    print(deviceName);

    server.listen(
      (client) {
        handleConnection(client);
        sendMessage(client, {
          "deviceName": deviceName,
          "type": MyPlatform.isWindows ? "computer" : "android"
        });
      },
    );
  }

  @override
  void onInit() {
    ini();
    super.onInit();
  }

  @override
  void onClose() {
    server.close();
    super.onClose();
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

  void handleConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');
    print("client port : ${client.port}");

    client.listen(
      (Uint8List data) async {
        print("time");
        final message = jsonDecode(String.fromCharCodes(data));
        if (message["start"]) {
          connectedDevice["ip"] = message["ip"];
          connectedDevice["name"] = message["name"];
          update();

          await sendingData(client);
        }

        client.close();
      },

      // handle errors
      onError: (error) {
        print(error);
        client.close();
      },

      // handle the client closing the connection
      onDone: () {
        print('Client left');

        client.close();
      },
    );
  }

  sendingData(Socket client) async {
    myData = await db.queryAllRows();

    sendMessage(client, {"data": myData});
    print("done sendeng");
    dataSended = true;
    update();
  }

  sendMessage(Socket socket, Map message) {
    print(message);
    socket.write(jsonEncode(message));
  }
}
