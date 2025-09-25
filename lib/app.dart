import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/routes/app_routes.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        theme: AppTheme.primaryTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.routes,
        builder: (context, child) => child!,
      ),
    );
  }
}
