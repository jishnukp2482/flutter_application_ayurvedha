import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/app.dart';
import 'package:flutter_application_ayurvedha/injecotr.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/utlities/local_storage_keywords.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await GetSecureStorage.init(password: LocalStorageKeyWords.securePassword);
  await setUp();
  runApp(const MyApp());
}
