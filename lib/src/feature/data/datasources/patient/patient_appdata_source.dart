import 'package:flutter_application_ayurvedha/src/feature/core/api_provider.dart';

abstract class PatientAppdataSource {}

class PatientAppdataSourceImpl extends PatientAppdataSource {
  final ApiProvider apiProvider;
  PatientAppdataSourceImpl(this.apiProvider);
}
