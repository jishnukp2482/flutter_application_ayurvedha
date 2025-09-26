import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonTColor,
    this.buttonBColor,
    this.textColor,
    this.width,
    this.height,
  });

  final String title;
  final Function onPressed;
  final Color? buttonTColor;
  final Color? buttonBColor;
  final Color? textColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width ?? w * 0.9.w,
      height: height ?? h * 0.055.h,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // buttonTColor ?? const Color(0xFFFF0000),
                buttonTColor ?? Theme.of(context).primaryColor,
                // buttonBColor ?? const Color(0xFFF95C3A)
                buttonBColor ?? Theme.of(context).primaryColorLight,
              ],
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomGradientLoadingButton extends StatelessWidget {
  const CustomGradientLoadingButton({
    super.key,
    this.buttonTColor,
    this.buttonBColor,
    this.textColor,
    this.width,
    this.height,
  });

  final Color? buttonTColor;
  final Color? buttonBColor;
  final Color? textColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width ?? w * 0.8.w,
      height: height ?? h * 0.06.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // buttonTColor ?? const Color(0xFFFF0000),
                buttonTColor ?? Theme.of(context).primaryColor,
                // buttonBColor ?? const Color(0xFFF95C3A)
                buttonBColor ?? Theme.of(context).primaryColorLight,
              ],
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: CircularProgressIndicator(color: AppColors.green),
          ),
        ),
      ),
    );
  }
}
