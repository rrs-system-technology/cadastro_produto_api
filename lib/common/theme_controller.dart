import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = ThemeMode.light;
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.dark;
    }
    Get.changeThemeMode(themeMode.value); // garante atualização
  }
}
