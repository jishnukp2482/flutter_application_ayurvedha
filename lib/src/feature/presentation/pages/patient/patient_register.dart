import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/response_classify.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/patient/patient_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/bottom_message.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_Custom_dropdown.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_custom_textfield.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/patient/add_treatment.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/patient/patient_treatment_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientRegister extends StatelessWidget {
  PatientRegister({super.key});
  final _formKey = GlobalKey<FormState>();
  final paymentOptions = ["Cash", "Card", "UPI"];
  @override
  Widget build(BuildContext context) {
    final pateintProvider = Provider.of<PatientProvider>(context);
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.h),
            child: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: AppColors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  pateintProvider.resetPatientForm();
                  context.pop();
                },
                icon: Icon(Icons.arrow_back, color: AppColors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Badge.count(
                    count: 1,
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
              flexibleSpace: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Divider(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                LabelCustomTextField(
                  hintText: "Enter Your full name",
                  textFieldLabel: "Name",
                  controller: pateintProvider.nameCntlr,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                LabelCustomTextField(
                  hintText: "Enter Your Whatsapp number",
                  textFieldLabel: "Whatsapp number",
                  controller: pateintProvider.whatsppnoCntlr,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Whatsapp number is required";
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return "Enter valid 10 digit number";
                    }
                    return null;
                  },
                ),
                LabelCustomTextField(
                  hintText: "Enter Your full address",
                  textFieldLabel: "Address",
                  controller: pateintProvider.addressCntlr,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Address is required";
                    }
                    return null;
                  },
                ),
                LabelWithDropDownField<String>(
                  textDropDownLabel: "Location",
                  items: ["Kochi", "Calicut"],
                  hintText: "Choose your location",
                  labelText: "Choose your location",
                  onChanged: (value) {
                    pateintProvider.location = value;
                  },
                  validator: (value) {
                    if (pateintProvider.location.isEmpty) {
                      return "Location is required";
                    }
                    return null;
                  },
                ),
                Consumer<PatientProvider>(
                  builder: (context, value, child) {
                    return LabelWithDropDownField<Branch>(
                      onBeforePopupOpening: (p0) async {
                        await value.getBranches(context);
                        return true;
                      },
                      textDropDownLabel: "Branch",
                      labelText: "select the branch",
                      itemAsString: (p0) => p0.name,
                      items: value.branchList,
                      hintText: "select the branch",
                      onChanged: (p0) {
                        value.selectedBranch = p0;
                      },
                      validator: (value) {
                        if (value == null || value.id == 0) {
                          return "Branch is required";
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Treatments",
                        style: GoogleFonts.poppins(color: AppColors.black),
                      ),
                      SizedBox(height: 10.h),
                      PatientTreatmentMenu(),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomGradientButton(
                    buttonBColor: AppColors.green.withOpacity(0.5),
                    buttonTColor: AppColors.green.withOpacity(0.5),
                    title: "+ Add Treatments",
                    textColor: AppColors.black,
                    onPressed: () {
                      showAddTreatments(context);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                LabelCustomTextField(
                  hintText: "",
                  textFieldLabel: "Total Amount",
                  controller: pateintProvider.totalAmoutCntlr,
                  validator: (value) {
                    if (value.isEmpty) return "Required";
                    return null;
                  },
                ),
                LabelCustomTextField(
                  hintText: "",
                  textFieldLabel: "Discount Amount",
                  controller: pateintProvider.discountAmoutCntlr,
                  inputType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: paymentOptions.map((option) {
                    return Row(
                      children: [
                        Radio<String>(
                          value: option,
                          groupValue: pateintProvider.selectedPayment,
                          onChanged: (value) {
                            if (value != null) {
                              pateintProvider.setPayment(value);
                            }
                          },
                        ),
                        Text(option),
                      ],
                    );
                  }).toList(),
                ),
                LabelCustomTextField(
                  hintText: "",
                  textFieldLabel: "Advance Amount",
                  controller: pateintProvider.advanceAmoutCntlr,
                  inputType: TextInputType.number,
                ),
                LabelCustomTextField(
                  hintText: "",
                  textFieldLabel: "Balance Amount",
                  controller: pateintProvider.balanceAmoutCntlr,
                  inputType: TextInputType.number,
                ),
                Consumer<PatientProvider>(
                  builder: (context, ref, child) {
                    return LabelCustomTextField(
                      hintText: "",
                      textFieldLabel: "Treatment Date",
                      readOnly: true,
                      onTap: () {
                        ref.pickTreatmentDate(context);
                      },

                      controller: ref.treatmentDateCntlr,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Date is required";
                        }
                        return null;
                      },
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<PatientProvider>(
                        builder: (context, value, child) {
                          return LabelWithDropDownField<String>(
                            textDropDownLabel: "Treatment Time",
                            items: value.hoursList,
                            hintText: "Hour",
                            labelText: "Hour",
                            selectedItem: value.hrPickUp.isEmpty
                                ? "Hour"
                                : value.hrPickUp,
                            onChanged: (p0) {
                              value.setHour(p0);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Hour required";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Consumer<PatientProvider>(
                        builder: (context, value, child) {
                          return LabelWithDropDownField<String>(
                            textDropDownLabel: "",
                            items: value.hoursList,
                            hintText: "Minutes",
                            labelText: "Minutes",
                            selectedItem: value.minutePickUp.isEmpty
                                ? "Minutes"
                                : value.minutePickUp,
                            onChanged: (p0) {
                              value.setMinute(p0);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Minutes required";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Consumer<PatientProvider>(
                    builder: (context, ref, child) {
                      return ref.patientRegState.status == Status.LOADING
                          ? Center(child: CircularProgressIndicator())
                          : CustomGradientButton(
                              title: "Save",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (ref.nameCntlr.text.isEmpty) {
                                    bottomMsg(
                                      context,
                                      "Failed",
                                      "Please enter name",
                                      false,
                                    );
                                    return;
                                  }
                                  if (ref.selectedPayment.isEmpty) {
                                    bottomMsg(
                                      context,
                                      "Failed",
                                      "Please select payment option",
                                      false,
                                    );
                                    return;
                                  }
                                  if (ref.addressCntlr.text.isEmpty) {
                                    bottomMsg(
                                      context,
                                      "Failed",
                                      "Please enter address",
                                      false,
                                    );
                                    return;
                                  }
                                  if (ref.selectedBranch.id == 0) {
                                    bottomMsg(
                                      context,
                                      "Failed",
                                      "Please select branch",
                                      false,
                                    );
                                    return;
                                  }
                                  if (ref.patientTreatmentList.isEmpty) {
                                    bottomMsg(
                                      context,
                                      "Failed",
                                      "Please select at least one treatment",
                                      false,
                                    );
                                    return;
                                  }

                                  ref.getPatientReg(
                                    context,
                                    ref.nameCntlr.text,
                                    ref
                                        .nameCntlr
                                        .text, // i dont know who is executive so just passing the name
                                    ref.selectedPayment,
                                    ref.whatsppnoCntlr.text,
                                    ref.addressCntlr.text,
                                    double.tryParse(ref.totalAmoutCntlr.text) ??
                                        0,
                                    double.tryParse(
                                          ref.discountAmoutCntlr.text,
                                        ) ??
                                        0,
                                    double.tryParse(
                                          ref.advanceAmoutCntlr.text,
                                        ) ??
                                        0,
                                    double.tryParse(
                                          ref.balanceAmoutCntlr.text,
                                        ) ??
                                        0,
                                    ref.getFormattedDateTime(),
                                    ref.getMaleTreatmentIds(),
                                    ref.getFemaleTreatmentIds(),
                                    ref.selectedBranch.id.toString(),
                                    ref.getAllTreatmentIds(),
                                  );
                                } else {
                                  bottomMsg(
                                    context,
                                    "Failed",
                                    "Please fill all required fields",
                                    false,
                                  );
                                }
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAddTreatments(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
      builder: (context) => const AddNewTreatMents(),
    );
  }
}
