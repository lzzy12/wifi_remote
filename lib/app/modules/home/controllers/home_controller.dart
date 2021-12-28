import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  static const String address = "FD01";
  final ipAddress = "192.168.13.250:80".obs;

  Future<bool> buttonPressed(String command) async {
    print(Uri.http(
      ipAddress.value,
      '/remote',
    ).toString());
    final res = await http.post(
        Uri.http(
          ipAddress.value,
          '/remote',
        ),
        body: jsonEncode({"address": address, "cmd": command}));
    print(res.statusCode);
    return res.statusCode == 200;
  }
}
