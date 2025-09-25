import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_assets.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: double.infinity,
                        child: Image.asset(
                          AppAssets.loginHeader,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 55.h),
                        child: Center(
                          child: SizedBox(
                            height: 70.h,
                            width: 70.w,
                            child: Image.asset(
                              AppAssets.appMiniLogo,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 10.h),
                    child: Column(
                      spacing: 10.h,
                      children: [
                        Text(
                          "Login Or Register To Book Your Appointments",
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        LabelCustomTextField(
                          hintText: "Enter Your Email",
                          textFieldLabel: "Email",
                        ),
                        LabelCustomTextField(
                          hintText: "Enter Your Password",
                          textFieldLabel: "Password",
                        ),
                        SizedBox(height: 30.h),
                        CustomGradientButton(title: "Login", onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Fixed Bottom Text
            Padding(
              padding: EdgeInsets.all(12.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    const TextSpan(
                      text:
                          'By creating or logging into an account you are agreeing with our ',
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
