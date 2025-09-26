import 'package:flutter_application_ayurvedha/src/feature/core/usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/request/patient/patient_reg_req_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_reg_res_modal.dart';


import 'package:flutter_application_ayurvedha/src/feature/data/repositories/patient/patient_repositories.dart';

class PatientRegUseCase extends UseCase<PatientRegResModal, PatientRegReqModal> {
  final PatientRepository patientRepository;

  PatientRegUseCase(this.patientRepository);

  @override
  Future<PatientRegResModal> call(params) async {
    return await patientRepository.regPatient(params);
  }
}
