import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/response_classify.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/request/patient/patient_reg_req_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart'
    as branch;
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_reg_res_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/treatment_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/entities/patient/patient_treatmentmodal.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/branch_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/patient_reg_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/patient_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/patient/treatment_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/bottom_message.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_print.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/patient/patient_treatment_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PatientProvider extends ChangeNotifier {
  final PatientUseCase patientUseCase;
  final BranchUsecase branchUsecase;
  final TreatmentUsecase treatmentUsecase;
  final PatientRegUseCase patientRegUseCase;
  PatientProvider(
    this.patientUseCase,
    this.branchUsecase,
    this.treatmentUsecase,
    this.patientRegUseCase,
  );

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

  ResponseClassify<TreatmentResponseModel> treatmentState =
      ResponseClassify<TreatmentResponseModel>.error("");

  ResponseClassify<TreatmentResponseModel> get treatmentResponse =>
      treatmentState;

  final treatmentList = <Treatment>[];

  Future<void> getTreatments(BuildContext context) async {
    treatmentState = ResponseClassify.loading();
    notifyListeners();

    try {
      final treatmentResponse = await treatmentUsecase.call(NoParams());

      if (treatmentResponse.status) {
        treatmentState = ResponseClassify.completed(treatmentResponse);

        treatmentList.clear();
        treatmentList.addAll(treatmentResponse.treatments);
      } else {
        treatmentState = ResponseClassify.error(treatmentResponse.message);
      }
    } catch (e) {
      treatmentState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      errorPrint("patient fetch error = $e");
    }

    notifyListeners();
  }

  final nameCntlr = TextEditingController();
  final whatsppnoCntlr = TextEditingController();
  final addressCntlr = TextEditingController();
  String location = "";
  var selectedBranch = branch.Branch(
    id: 0,
    name: "",
    patientsCount: 0,
    location: "",
    phone: "",
    mail: "",
    address: "",
    gst: "",
    isActive: false,
  );
  final totalAmoutCntlr = TextEditingController();
  final discountAmoutCntlr = TextEditingController();
  final advanceAmoutCntlr = TextEditingController();
  final balanceAmoutCntlr = TextEditingController();
  final treatmentDateCntlr = TextEditingController();
  var selectedTreatMent = Treatment(
    id: 0,
    branches: [],
    name: "",
    duration: "",
    price: "",
    isActive: false,
    createdAt: "",
    updatedAt: "",
  );
  String hrPickUp = "";
  String minutePickUp = "";

  Future<void> pickTreatmentDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      treatmentDateCntlr.text = formattedDate;
      notifyListeners();
    }
  }

  List<String> hoursList = List.generate(
    24,
    (index) => index.toString().padLeft(2, '0'),
  );
  List<String> minutesList = List.generate(
    60,
    (index) => index.toString().padLeft(2, '0'),
  );
  void setHour(String value) {
    hrPickUp = value;
    notifyListeners();
  }

  void setMinute(String value) {
    minutePickUp = value;
    notifyListeners();
  }

  final patientTreatmentList = <PatientTreatmentmodal>[];
  bool addtreatMent = false;
  void addOrUpdateTreatment(PatientTreatmentmodal modal, BuildContext context) {
    addtreatMent = true;
    notifyListeners();
    final index = patientTreatmentList.indexWhere(
      (item) => item.treatment.id == modal.treatment.id,
    );

    if (index != -1) {
      patientTreatmentList[index] = modal;
    } else {
      patientTreatmentList.add(modal);
    }
    addtreatMent = false;
    selectedTreatMent = Treatment(
      id: 0,
      branches: [],
      name: "",
      duration: "",
      price: "",
      isActive: false,
      createdAt: "",
      updatedAt: "",
    );
    treatmentMaleCount = 0;
    treatmentFemaleCount = 0;

    notifyListeners();
    context.pop();
  }

  int treatmentMaleCount = 0;
  int treatmentFemaleCount = 0;

  void updateTreatmentMaleCount(bool isIncrement) {
    if (isIncrement) {
      treatmentMaleCount++;
    } else {
      if (treatmentMaleCount > 0) treatmentMaleCount--;
    }
    notifyListeners();
  }

  void updateTreatmentFemaleCount(bool isIncrement) {
    if (isIncrement) {
      treatmentFemaleCount++;
    } else {
      if (treatmentFemaleCount > 0) treatmentFemaleCount--;
    }
    notifyListeners();
  }

  void resetPatientForm() {
    nameCntlr.clear();
    whatsppnoCntlr.clear();
    addressCntlr.clear();
    totalAmoutCntlr.clear();
    discountAmoutCntlr.clear();
    advanceAmoutCntlr.clear();
    balanceAmoutCntlr.clear();
    treatmentDateCntlr.clear();

    location = "";

    selectedBranch = branch.Branch(
      id: 0,
      name: "",
      patientsCount: 0,
      location: "",
      phone: "",
      mail: "",
      address: "",
      gst: "",
      isActive: false,
    );

    selectedTreatMent = Treatment(
      id: 0,
      branches: [],
      name: "",
      duration: "",
      price: "",
      isActive: false,
      createdAt: "",
      updatedAt: "",
    );

    hrPickUp = "";
    minutePickUp = "";
    patientTreatmentList.clear();
    selectedPayment = "Cash";
    notifyListeners();
  }

  ResponseClassify<PatientRegResModal> patientRegState =
      ResponseClassify<PatientRegResModal>.error("");

  ResponseClassify<PatientRegResModal> get patientRegResponse =>
      patientRegState;

  final patientRegList = <Treatments>[];

  Future<void> getPatientReg(
    BuildContext context,
    String name,
    String excecutive,
    String payment,
    String phone,
    String address,
    double totalAmount,
    double discountAmount,
    double advanceAmount,
    double balanceAmount,
    String dateNdTime,
    String male,
    String female,
    String branch,
    String treatments,
  ) async {
    patientRegState = ResponseClassify.loading();
    notifyListeners();

    try {
      final patientRequest = PatientRegReqModal(
        name: name,
        excecutive: excecutive,
        payment: payment,
        phone: phone,
        address: address,
        total_amount: totalAmount,
        discount_amount: discountAmount,
        advance_amount: advanceAmount,
        balance_amount: balanceAmount,
        date_nd_time: dateNdTime,
        id: "",
        male: male,
        female: female,
        branch: branch,
        treatments: treatments,
      );

      final patientRegResponse = await patientRegUseCase.call(patientRequest);

      if (patientRegResponse.status) {
        patientRegState = ResponseClassify.completed(patientRegResponse);

        patientRegList.clear();
        patientRegList.addAll(patientRegResponse.treatments);
      } else {
        patientRegState = ResponseClassify.error(patientRegResponse.message);
      }
      resetPatientForm();
      context.pop();
    } catch (e) {
      patientRegState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      errorPrint("Patient fetch error = $e");
    }

    notifyListeners();
  }

  String getFormattedDateTime() {
    if (treatmentDateCntlr.text.isEmpty ||
        hrPickUp.isEmpty ||
        minutePickUp.isEmpty) {
      return "";
    }

    DateTime date = DateFormat('dd-MM-yyyy').parse(treatmentDateCntlr.text);

    DateTime finalDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(hrPickUp),
      int.parse(minutePickUp),
    );

    String formatted = DateFormat('dd/MM/yyyy-hh:mm a').format(finalDateTime);

    return formatted;
  }

  String getMaleTreatmentIds() {
    final maleIds = patientTreatmentList
        .where(
          (t) =>
              int.tryParse(t.maleCount) != null && int.parse(t.maleCount) > 0,
        )
        .map((t) => t.treatment.id.toString())
        .toList();

    return maleIds.join(',');
  }

  String getFemaleTreatmentIds() {
    final femaleIds = patientTreatmentList
        .where(
          (t) =>
              int.tryParse(t.femaleCount) != null &&
              int.parse(t.femaleCount) > 0,
        )
        .map((t) => t.treatment.id.toString())
        .toList();

    return femaleIds.join(',');
  }

  String getAllTreatmentIds() {
    final allIds = patientTreatmentList
        .map((t) => t.treatment.id.toString())
        .toList();

    return allIds.join(',');
  }

  String selectedPayment = "Cash";

  void setPayment(String value) {
    selectedPayment = value;
    notifyListeners();
  }
}
