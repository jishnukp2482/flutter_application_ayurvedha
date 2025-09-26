import 'package:flutter_application_ayurvedha/src/feature/core/usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';

import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';

import 'package:flutter_application_ayurvedha/src/feature/data/repositories/patient/patient_repositories.dart';

class BranchUsecase extends UseCase<BranchResponseModel, NoParams> {
  final PatientRepository patientRepository;

  BranchUsecase(this.patientRepository);

  @override
  Future<BranchResponseModel> call(params) async {
    return await patientRepository.getBranches();
  }
}
