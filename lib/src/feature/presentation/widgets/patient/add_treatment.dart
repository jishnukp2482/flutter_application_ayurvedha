import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/treatment_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/entities/patient/patient_treatmentmodal.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/patient/patient_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/bottom_message.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_Custom_dropdown.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewTreatMents extends StatelessWidget {
  const AddNewTreatMents({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return Card(
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 10.w,
              right: 10.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: ListView(
              children: [
                Consumer<PatientProvider>(
                  builder: (context, value, child) {
                    return LabelWithDropDownField<Treatment>(
                      onBeforePopupOpening: (p0) async {
                        await value.getTreatments(context);
                        return true;
                      },
                      textDropDownLabel: "Choose Treatment",
                      labelText: "Choose Tratment",
                      itemAsString: (p0) => p0.name,
                      items: value.treatmentList,
                      hintText: "Choose prefered TreatMents",
                      onChanged: (p0) {
                        value.selectedTreatMent = p0;
                      },
                    );
                  },
                ),

                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: LabelCustomTextField(
                        textFieldLabel: "Add Patients",
                        hintText: "Male",
                        labelText: "Male",
                        readOnly: true,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Consumer<PatientProvider>(
                          builder: (context, ref, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref.updateTreatmentMaleCount(false);
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.green),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${ref.treatmentMaleCount}",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref.updateTreatmentMaleCount(true);
                                  },
                                  child: Container(
                                    height: 50.w,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: LabelCustomTextField(
                        textFieldLabel: "",
                        hintText: "Female",
                        labelText: "Female",
                        readOnly: true,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Consumer<PatientProvider>(
                          builder: (context, ref, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref.updateTreatmentFemaleCount(false);
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.green),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${ref.treatmentFemaleCount}",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref.updateTreatmentFemaleCount(true);
                                  },
                                  child: Container(
                                    height: 50.w,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Consumer<PatientProvider>(
                    builder: (context, ref, child) {
                      return ref.addtreatMent
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.green,
                              ),
                            )
                          : CustomGradientButton(
                              title: "Save",
                              onPressed: () {
                                if (ref.selectedTreatMent.name.isEmpty) {
                                  bottomMsg(
                                    context,
                                    "Failed",
                                    "Please Select a Treatment",
                                    false,
                                  );
                                  return;
                                }
                                if (ref.treatmentMaleCount == 0 &&
                                    ref.treatmentFemaleCount == 0) {
                                  bottomMsg(
                                    context,
                                    "Failed",
                                    "Please Select atlaeast one patient",
                                    false,
                                  );
                                  return;
                                }

                                ref.addOrUpdateTreatment(
                                  PatientTreatmentmodal(
                                    ref.selectedTreatMent,
                                    ref.treatmentMaleCount.toString(),
                                    ref.treatmentFemaleCount.toString(),
                                  ),

                                  context,
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
