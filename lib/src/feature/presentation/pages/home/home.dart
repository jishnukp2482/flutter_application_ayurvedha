import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/routes/app_pages.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/home/exisiting_patient_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(210.h),
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
            padding: EdgeInsets.fromLTRB(20.w, 100.h, 20.w, 10.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          hintText: "Search",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: CustomGradientButton(
                          title: "Search",
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sort by :",
                      style: GoogleFonts.poppins(color: AppColors.black),
                    ),
                    Container(
                      height: 35.h,
                      width: 150.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: "Date",
                          items: [
                            DropdownMenuItem(
                              value: "Date",
                              child: Text("Date"),
                            ),
                          ],
                          onChanged: (value) {},
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                  ],
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
      body: ListView(children: [PatientListMenu()]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: CustomGradientButton(
          title: "Register Now",
          onPressed: () {
            context.pushNamed(AppPages.pateintRegister);
          },
        ),
      ),
    );
  }
}
