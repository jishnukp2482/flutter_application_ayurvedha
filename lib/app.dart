import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/injecotr.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/auth/auth_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/patient/patient_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/routes/app_routes.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider(sl())),
          ChangeNotifierProvider(create: (context) => PatientProvider(sl(),sl())),
        ],
        child: MaterialApp.router(
          theme: AppTheme.primaryTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.routes,
          builder: (context, child) => child!,
        ),
      ),
    );
  }
}
