import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_Custom_dropdown.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
                LabelWithDropDownField(
                  hintText: "Choose prefered TreatMents",
                  textDropDownLabel: "Choose Treatment",
                  labelText: "Choose Tratment",
                  items: [],
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
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
                                  "1",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.w,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, color: AppColors.white),
                              ),
                            ),
                          ],
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
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
                                  "1",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.w,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomGradientButton(title: "Save", onPressed: () {}),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
