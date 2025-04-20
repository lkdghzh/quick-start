# 交友

这是一个使用 GetX 状态管理的 Flutter 交友项目，采用清晰的目录结构和模块化设计。

## 项目结构

```
lib/app/
├── controllers/        # 全局控制器
│   ├── app_controller.dart     # 应用全局状态控制器
│   └── auth_controller.dart    # 认证状态控制器
├── bindings/          # 依赖注入绑定
│   ├── initial_binding.dart    # 初始化绑定
│   └── navigation_binding.dart # 导航绑定
└── modules/          # 功能模块
    └── chat/         # 聊天模块示例
        ├── bindings/
        ├── controllers/
        └── views/
```

## 全局控制器

### AppController

全局应用状态控制器，管理应用级别的状态和配置。

```dart
class AppController extends GetxController {
  // 获取实例
  static AppController get to => Get.find();

  // 状态变量
  final RxBool isDarkMode = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString currentUser = ''.obs;

  // 主题切换
  void toggleTheme() { ... }

  // 登录状态管理
  void login(String username) { ... }
  void logout() { ... }

  // 全局配置管理
  final RxMap<String, dynamic> appConfig = { ... }.obs;
  void updateConfig(String key, dynamic value) { ... }
}
```

### AuthController

认证控制器，处理用户认证相关的状态和操作。

```dart
class AuthController extends GetxController {
  static AuthController get to => Get.find();

  // 状态变量
  final RxBool isLoading = false.obs;
  final RxString token = ''.obs;
  final Rx<DateTime?> tokenExpiry = Rx<DateTime?>(null);
  final RxMap<String, dynamic> userInfo = <String, dynamic>{}.obs;

  // 认证方法
  Future<bool> login(String username, String password) async { ... }
  Future<void> logout() async { ... }
  Future<bool> refreshToken() async { ... }
  Future<bool> updateUserInfo(Map<String, dynamic> newInfo) async { ... }
}
```

## 依赖注入

### InitialBinding

应用初始化时的绑定，处理所有全局控制器的注入和启动时的必要操作。这是应用的核心绑定类，负责：

1. 注入全局控制器
2. 初始化应用配置
3. 检查并处理登录状态
4. 加载主题设置
5. 其他启动时必要的初始化操作

```dart
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 注入全局控制器
    Get.put(AppController(), permanent: true);
    Get.put(AuthController(), permanent: true);

    // 初始化操作
    final appController = Get.find<AppController>();
    final authController = Get.find<AuthController>();

    // 加载主题设置
    appController.isDarkMode.value = false;

    // 检查登录状态
    if (authController.isLoggedIn) {
      authController.refreshToken();
    } else {
      Get.offAllNamed('/login');
    }

    // 其他初始化操作...
  }
}
```

## 使用方法

### 1. 初始化应用

在 `main.dart` 中初始化：

```dart
void main() {
  runApp(
    GetMaterialApp(
      initialBinding: InitialBinding(), // 这里使用 InitialBinding 进行全局初始化
      // ...
    ),
  );
}
```

### 2. 在视图中使用控制器

```dart
// 方法 1：使用 Get.find
final appController = Get.find<AppController>();
final authController = Get.find<AuthController>();

// 方法 2：使用静态 to 方法
AppController.to.toggleTheme();
AuthController.to.login('username', 'password');
```

### 3. 响应式状态管理

```dart
// 在视图中使用 Obx 观察状态变化
Obx(() => Text(AppController.to.currentUser.value));

// 在控制器中更新状态
AppController.to.currentUser.value = 'new username';
```

### 4. 路由导航

```dart
// 导航到新页面
Get.toNamed('/chat/list');

// 带参数导航
Get.toNamed('/chat/detail', arguments: {'id': '123'});

// 返回上一页
Get.back();

// 清除所有页面并导航
Get.offAllNamed('/login');
```

## 最佳实践

1. 使用 `permanent: true` 保持全局控制器常驻内存
2. 使用 `.obs` 创建响应式状态
3. 在 `InitialBinding` 中处理应用初始化逻辑
4. 使用 `static get to => Get.find()` 方便获取控制器实例
5. 将业务逻辑封装在控制器中，保持视图层简洁

## 注意事项

1. 确保在使用控制器前已经注入
2. 合理使用 `permanent` 参数，避免内存泄漏
3. 注意状态更新的性能影响
4. 适当处理异步操作的加载状态
5. 正确处理控制器的生命周期
