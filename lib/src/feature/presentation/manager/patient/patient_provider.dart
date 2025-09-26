import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/response_classify.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart'
    as branch;
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/branch_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/patient_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/bottom_message.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_print.dart';

class PatientProvider extends ChangeNotifier {
  final PatientUseCase patientUseCase;
  final BranchUsecase branchUsecase;
  PatientProvider(this.patientUseCase, this.branchUsecase);

  ResponseClassify<PatientResponseModel> patientState =
      ResponseClassify<PatientResponseModel>.error("");

  ResponseClassify<PatientResponseModel> get patientResponse => patientState;

  final patientList = <Patient>[];

  Future<void> getPatients(BuildContext context) async {
    patientState = ResponseClassify.loading();
    notifyListeners();

    try {
      final patientResponse = await patientUseCase.call(NoParams());

      if (patientResponse.status) {
        patientState = ResponseClassify.completed(patientResponse);

        patientList.clear();
        patientList.addAll(patientResponse.patients);

        bottomMsg(context, "Success", patientResponse.message, true);
      } else {
        patientState = ResponseClassify.error(patientResponse.message);
        bottomMsg(context, "Failed", patientResponse.message, false);
      }
    } catch (e) {
      patientState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      errorPrint("patient fetch error = $e");
    }

    notifyListeners();
  }

  ResponseClassify<branch.BranchResponseModel> branchState =
      ResponseClassify<branch.BranchResponseModel>.error("");

  ResponseClassify<branch.BranchResponseModel> get branchResponse =>
      branchState;

  final branchList = <branch.Branch>[];

  Future<void> getBranches(BuildContext context) async {
    branchState = ResponseClassify.loading();
    notifyListeners();

    try {
      final branchResponse = await branchUsecase.call(NoParams());

      if (branchResponse.status) {
        branchState = ResponseClassify.completed(branchResponse);

        branchList.clear();
        branchList.addAll(branchResponse.branches);
      } else {
        branchState = ResponseClassify.error(branchResponse.message);
      }
    } catch (e) {
      branchState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      errorPrint("patient fetch error = $e");
    }

    notifyListeners();
  }
}
