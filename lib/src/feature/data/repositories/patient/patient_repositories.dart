import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';

abstract class PatientRepository {
   Future<PatientResponseModel> getPatients();
    Future<BranchResponseModel> getBranches();
}
