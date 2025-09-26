import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/response_classify.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/patient_response_model.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/patient/patient_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientListMenu extends StatefulWidget {
  const PatientListMenu({super.key});

  @override
  State<PatientListMenu> createState() => _PatientListMenuState();
}

class _PatientListMenuState extends State<PatientListMenu> {
  late PatientProvider patientProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientProvider = Provider.of<PatientProvider>(context, listen: false);
      patientProvider.getPatients(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, value, child) {
        if (value.patientState.status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.green),
          );
        } else if (value.patientList.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Center(child: Text("No Patients Found")),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20.w),
            itemCount: value.patientList.length,
            shrinkWrap: true,

            itemBuilder: (context, index) {
              return PatientListItem(
                patient: value.patientList[index],
                itemCount: index,
              );
            },
          );
        }
      },
    );
  }
}

class PatientListItem extends StatelessWidget {
  const PatientListItem({
    super.key,
    required this.patient,
    required this.itemCount,
  });
  final Patient patient;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    final details = patient.patientDetails;
    final treatmentName = details.isNotEmpty
        ? details.first.treatmentName
        : 'No treatment';

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Card(
        color: AppColors.white.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            spacing: 5.h,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${itemCount + 1}.",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      spacing: 5.h,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            treatmentName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AppColors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.red,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    getFormattedDate(patient.createdAt),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.supervisor_account_outlined,
                                    color: AppColors.red,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      patient.user,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: AppColors.black,
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
                ],
              ),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 5.h),
                child: Divider(),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View Booking Details",
                      style: GoogleFonts.poppins(color: AppColors.black),
                    ),
                    GestureDetector(
                      onTap: () {},

                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.green,
                        size: 16.sp,
                      ),
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

  String getFormattedDate(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);

      return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateTimeString;
    }
  }
}
