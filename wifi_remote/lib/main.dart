import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wifi_remote/app/services/app_theme_service.dart';

import 'app/routes/app_pages.dart';

void main() {
  initServices();
  runApp(
    GetMaterialApp(
      title: "ESP32 Remote Controll",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

void initServices() {
  Get.put(AppThemeService());
}
