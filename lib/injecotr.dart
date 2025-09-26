import 'package:flutter_application_ayurvedha/src/feature/core/api_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/connection_checker.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/datasources/auth/auth_appdata_source.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/datasources/patient/patient_appdata_source.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/repositories/auth/auth_repositories.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/repositories/patient/patient_repositories.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/repositories/auth/auth_repository_impl.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/repositories/patient/patient_repository_impl.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/branch_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/patient_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());

  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );
  sl.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(sl()),
  );

  sl.registerLazySingleton<AuthAppdataSource>(
    () => AuthAppdataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));


  sl.registerLazySingleton<PatientAppdataSource>(
    () => PatientAppdataSourceImpl(sl()),
  );

  sl.registerLazySingleton<PatientRepository>(() => PatientRepositoryImpl(sl()));
  sl.registerLazySingleton<PatientUseCase>(() => PatientUseCase(sl()));
  sl.registerLazySingleton<BranchUsecase>(() => BranchUsecase(sl()));
}
