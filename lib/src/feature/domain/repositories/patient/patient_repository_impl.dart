import 'package:flutter_application_ayurvedha/src/feature/data/datasources/patient/patient_appdata_source.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/repositories/patient/patient_repositories.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientAppdataSource patientAppdataSource;
  PatientRepositoryImpl(this.patientAppdataSource);

  @override
  Future<PatientResponseModel> getPatients() async {
    return patientAppdataSource.getPatients();
  }

  @override
  Future<BranchResponseModel> getBranches() async {
    return patientAppdataSource.getBranches();
  }
}
