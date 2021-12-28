import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  static const String address = "FD01";
  String _ipAddress = "192.168.13.250";
  static final RegExp ipRegex = RegExp(
      r"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");

  String? ipAddressValidator(String? value) {
    if (value == null) return "Please enter an IP address";
    if (ipRegex.hasMatch(value)) {
      _ipAddress = value;
      return null;
    } else {
      return "Please enter a valid IP address";
    }
  }

  void onFormSave() {
    print("kekw");
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.validate()) {
      return;
    }
    _ipAddress = ipAddressController.text;
  }

  
  final ipAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<bool> buttonPressed(String command) async {
    print(Uri.http(
      _ipAddress,
      '/remote',
    ).toString());
    final res = await http.post(
        Uri.http(
          _ipAddress,
          '/remote',
        ),
        body: jsonEncode({"address": address, "cmd": command}));
    print(res.statusCode);
    return res.statusCode == 200;
  }
}
