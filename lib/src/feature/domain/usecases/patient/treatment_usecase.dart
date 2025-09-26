import 'package:flutter_application_ayurvedha/src/feature/core/usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/treatment_modal.dart';

import 'package:flutter_application_ayurvedha/src/feature/data/repositories/patient/patient_repositories.dart';

class TreatmentUsecase extends UseCase<TreatmentResponseModel, NoParams> {
  final PatientRepository patientRepository;

  TreatmentUsecase(this.patientRepository);

  @override
  Future<TreatmentResponseModel> call(params) async {
    return await patientRepository.getTreatments();
  }
}
