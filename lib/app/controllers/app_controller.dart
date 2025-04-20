import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  // 全局状态
  final RxBool isDarkMode = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString currentUser = ''.obs;

  // 主题切换
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // 登录状态管理
  void login(String username) {
    isLoggedIn.value = true;
    currentUser.value = username;
  }

  void logout() {
    isLoggedIn.value = false;
    currentUser.value = '';
    Get.offAllNamed('/login');
  }

  // 全局配置
  final RxMap<String, dynamic> appConfig =
      <String, dynamic>{
        'apiUrl': 'https://api.example.com',
        'version': '1.0.0',
        'buildNumber': '1',
      }.obs;

  // 更新配置
  void updateConfig(String key, dynamic value) {
    appConfig[key] = value;
  }
}
