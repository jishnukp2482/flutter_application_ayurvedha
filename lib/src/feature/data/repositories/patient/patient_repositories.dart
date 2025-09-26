import 'package:flutter_application_ayurvedha/src/feature/data/models/request/patient/patient_reg_req_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_reg_res_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/treatment_modal.dart';

abstract class PatientRepository {
   Future<PatientResponseModel> getPatients();
    Future<BranchResponseModel> getBranches();
      Future<TreatmentResponseModel> getTreatments();
        Future<PatientRegResModal> regPatient(PatientRegReqModal modal);
}
