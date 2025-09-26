import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/patient/branch_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/patient/patient_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_Custom_dropdown.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_custom_textfield.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/patient/add_treatment.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/patient/patient_treatment_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientRegister extends StatelessWidget {
  const PatientRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back, color: AppColors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Badge.count(
                  count: 1,
                  child: Icon(Icons.notifications_none, color: AppColors.black),
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
        body: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            LabelCustomTextField(
              hintText: "Enter Your full name",
              textFieldLabel: "Name",
            ),
            LabelCustomTextField(
              hintText: "Enter Your Whatsapp number",
              textFieldLabel: "Whatsapp number",
            ),
            LabelCustomTextField(
              hintText: "Enter Your full address",
              textFieldLabel: "Address",
            ),
            LabelWithDropDownField(
              textDropDownLabel: "Location",
              items: [],
              hintText: "Choose your location",
              labelText: "Choose your location",
            ),
            Consumer<PatientProvider>(
              builder: (context, value, child) {
                return LabelWithDropDownField<Branch>(
                  onBeforePopupOpening: (key) async {
                    await value.getBranches(context);
                    return true;
                  },
                  textDropDownLabel: "Branch",
                  labelText: "select the branch",
                  items: value.branchList,
                  hintText: "select the branch",
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
            LabelCustomTextField(hintText: "", textFieldLabel: "Total Amount"),
            LabelCustomTextField(
              hintText: "",
              textFieldLabel: "Discount Amount",
            ),
            LabelCustomTextField(
              hintText: "",
              textFieldLabel: "Advance Amount",
            ),
            LabelCustomTextField(
              hintText: "",
              textFieldLabel: "Balance Amount",
            ),
            LabelCustomTextField(
              hintText: "",
              textFieldLabel: "Treatment Date",
            ),
            Row(
              children: [
                Expanded(
                  child: LabelWithDropDownField(
                    textDropDownLabel: "Treatment Time",
                    items: [],
                    hintText: "Hour",
                    labelText: "Hour",
                  ),
                ),
                Expanded(
                  child: LabelWithDropDownField(
                    textDropDownLabel: "",
                    items: [],
                    hintText: "Minutes",
                    labelText: "Minutes",
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
