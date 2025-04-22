import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/bindings/initial_binding.dart';
import 'app/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print('--${MediaQuery.of(context).size} ');
    return ScreenUtilInit(
      // 基准宽度 375px，高度 812px（iPhone X、iPhone 11 Pro、iPhone 12 mini、iPhone 13 mini）
      designSize: const Size(375, 812),
      // 基准宽度 375px，高度 812px（iPhone 6）
      // designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'SiM',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          initialBinding: InitialBinding(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
