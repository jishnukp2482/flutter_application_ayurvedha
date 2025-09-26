import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/response_classify.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/manager/auth/auth_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_assets.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_button.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/label_custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 12.h,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login Or Register To Book\nYour Appointments",
                                style: GoogleFonts.poppins(
                                  color: AppColors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              LabelCustomTextField(
                                hintText: "Enter Your Email",
                                textFieldLabel: "Email",
                                controller: authProvider.userNameCnltr,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              LabelCustomTextField(
                                hintText: "Enter Your Password",
                                textFieldLabel: "Password",
                                controller: authProvider.passwordCntlr,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.h),
                              Consumer<AuthProvider>(
                                builder: (context, value, child) {
                                  return value.loginstate.status ==
                                          Status.LOADING
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.green,
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                          ),
                                          child: CustomGradientButton(
                                            title: "Login",
                                            onPressed:
                                                value.loginstate.status ==
                                                    Status.LOADING
                                                ? () {}
                                                : () {
                                                    if (formKey.currentState
                                                            ?.validate() ??
                                                        false) {
                                                      authProvider.getLogin(
                                                        authProvider
                                                            .userNameCnltr
                                                            .text,
                                                        authProvider
                                                            .passwordCntlr
                                                            .text,
                                                        context,
                                                      );
                                                    }
                                                  },
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    'By creating or logging into an account you are agreeing with our ',
                              ),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
