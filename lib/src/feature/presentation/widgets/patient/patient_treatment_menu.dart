import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/entities/patient/patient_treatmentmodal.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/patient/patient_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientTreatmentMenu extends StatelessWidget {
  const PatientTreatmentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, ref, child) {
        if (ref.addtreatMent) {
          return Center(child: CircularProgressIndicator());
        } else if (ref.patientTreatmentList.isEmpty) {
          return Center(child: Text("No Data Found"));
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ref.patientTreatmentList.length,
            itemBuilder: (context, index) {
              return TreamentItem(
                count: index,
                modal: ref.patientTreatmentList[index],
              );
            },
          );
        }
      },
    );
  }
}

class TreamentItem extends StatelessWidget {
  const TreamentItem({super.key, required this.count, required this.modal});
  final int count;
  final PatientTreatmentmodal modal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "${count + 1} .",
                  style: GoogleFonts.poppins(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modal.treatment.name,
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            spacing: 10.w,
                            children: [
                              Text(
                                "Male",
                                style: GoogleFonts.poppins(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 20.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Text(
                                    modal.maleCount,
                                    style: GoogleFonts.poppins(
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            spacing: 10.w,
                            children: [
                              Text(
                                modal.femaleCount,
                                style: GoogleFonts.poppins(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 20.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.green),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 12.h,
                  children: [
                    Container(
                      height: 20.w,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear,
                        color: AppColors.white,
                        size: 12.sp,
                      ),
                    ),
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.green,
                      size: 17.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
