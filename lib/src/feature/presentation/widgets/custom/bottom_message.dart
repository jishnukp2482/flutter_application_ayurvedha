import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void bottomMsg(
  BuildContext context,
  String title,
  String msg,
  bool isSuccess, {
  bool isLoading = false,
}) {
  final Color primaryColor = isSuccess
      ? const Color(0xFF4CAF50)
      : const Color(0xFFF44336);
  final Color accentColor = isSuccess
      ? const Color(0xFFE8F5E9)
      : const Color(0xFFFFEBEE);

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    duration: isLoading
        ? const Duration(seconds: 10)
        : const Duration(seconds: 4),
    elevation: 0,
    padding: EdgeInsets.zero,
    content: Container(
      padding: EdgeInsets.only(left: 8.w, right: 16.w, top: 16.h, bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontSize: 16.sp,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        color: AppColors.green,
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    )
                  : Icon(
                      isSuccess
                          ? Icons.check_circle_rounded
                          : Icons.error_rounded,
                      color: primaryColor,
                      size: 24.sp,
                    ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              msg,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
