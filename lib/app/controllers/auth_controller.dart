import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final RxBool isLoading = false.obs;
  final RxString token = ''.obs;
  final Rx<DateTime?> tokenExpiry = Rx<DateTime?>(null);

  // 用户信息
  final RxMap<String, dynamic> userInfo = <String, dynamic>{}.obs;

  // 登录
  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    try {
      // TODO: 实现实际的登录逻辑
      await Future.delayed(Duration(seconds: 2)); // 模拟网络请求

      // 模拟成功登录
      token.value = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      tokenExpiry.value = DateTime.now().add(Duration(days: 7));

      userInfo.value = {
        'id': '1',
        'username': username,
        'email': '$username@example.com',
        'avatar': 'https://via.placeholder.com/150',
      };

      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // 登出
  Future<void> logout() async {
    isLoading.value = true;
    try {
      // TODO: 实现实际的登出逻辑
      await Future.delayed(Duration(seconds: 1)); // 模拟网络请求

      token.value = '';
      tokenExpiry.value = null;
      userInfo.clear();

      Get.offAllNamed('/login');
    } catch (e) {
      print('Logout error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 检查登录状态
  bool get isLoggedIn =>
      token.isNotEmpty &&
      tokenExpiry.value != null &&
      tokenExpiry.value!.isAfter(DateTime.now());

  // 刷新token
  Future<bool> refreshToken() async {
    try {
      // TODO: 实现实际的token刷新逻辑
      await Future.delayed(Duration(seconds: 1)); // 模拟网络请求

      token.value = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      tokenExpiry.value = DateTime.now().add(Duration(days: 7));

      return true;
    } catch (e) {
      print('Token refresh error: $e');
      return false;
    }
  }

  // 更新用户信息
  Future<bool> updateUserInfo(Map<String, dynamic> newInfo) async {
    isLoading.value = true;
    try {
      // TODO: 实现实际的更新逻辑
      await Future.delayed(Duration(seconds: 1)); // 模拟网络请求

      userInfo.addAll(newInfo);
      return true;
    } catch (e) {
      print('Update user info error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
