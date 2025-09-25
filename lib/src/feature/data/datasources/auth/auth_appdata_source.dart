import 'package:flutter_application_ayurvedha/src/feature/core/api_provider.dart';

abstract class AuthAppdataSource {}

class AuthAppdataSourceImpl extends AuthAppdataSource {
  final ApiProvider apiProvider;
  AuthAppdataSourceImpl(this.apiProvider);
}
