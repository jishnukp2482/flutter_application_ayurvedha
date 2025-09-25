import 'package:flutter_application_ayurvedha/src/feature/data/datasources/auth/auth_appdata_source.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/repositories/auth/auth_repositories.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthAppdataSource authAppdataSource;
  AuthRepositoryImpl(this.authAppdataSource);
}
