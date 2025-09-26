import 'package:flutter_application_ayurvedha/src/feature/core/api_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/request/patient/patient_reg_req_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_reg_res_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/treatment_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/remotes/app_remote_routes.dart';

abstract class PatientAppdataSource {
  Future<PatientResponseModel> getPatients();
  Future<BranchResponseModel> getBranches();
  Future<TreatmentResponseModel> getTreatments();
  Future<PatientRegResModal> regPatient(PatientRegReqModal modal);
}

class PatientAppdataSourceImpl extends PatientAppdataSource {
  final ApiProvider apiProvider;
  PatientAppdataSourceImpl(this.apiProvider);

  @override
  Future<PatientResponseModel> getPatients() async {
    return PatientResponseModel.fromJson(
      await apiProvider.get(AppRemoteRoutes.getPatients),
    );
  }

  @override
  Future<BranchResponseModel> getBranches() async {
    return BranchResponseModel.fromJson(
      await apiProvider.get(AppRemoteRoutes.getBranches),
    );
  }

  @override
  Future<TreatmentResponseModel> getTreatments() async {
    return TreatmentResponseModel.fromJson(
      await apiProvider.get(AppRemoteRoutes.getTreatments),
    );
  }

  @override
  Future<PatientRegResModal> regPatient(PatientRegReqModal modal) async {
    return PatientRegResModal.fromJson(
      await apiProvider.post(AppRemoteRoutes.patientReg, modal.toMap(),isFormData: true),
    );
  }
}
