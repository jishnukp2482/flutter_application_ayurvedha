import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/pages/auth/signin.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/pages/home/home.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/pages/patient/patient_register.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/pages/splash_screen.dart'
    show SplashScreen;
import 'package:flutter_application_ayurvedha/src/feature/presentation/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter routes = GoRouter(
    initialLocation: AppPages.splashScreen,
    routes: [
      GoRoute(
        path: AppPages.splashScreen,
        name: AppPages.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppPages.loginPage,
        name: AppPages.loginPage,
        builder: (context, state) => SigninScreen(),
      ),
      GoRoute(
        path: AppPages.homePage,
        name: AppPages.homePage,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: AppPages.pateintRegister,
        name: AppPages.pateintRegister,
        builder: (context, state) => PatientRegister(),
      ),
    ],
  );
}
