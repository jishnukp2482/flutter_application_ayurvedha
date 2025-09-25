

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void bottomMsg(
  String title,
  String msg,
  bool isSuccess, {
  bool isLoading = false,
}) {
  final Color primaryColor =
      isSuccess ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
  final Color accentColor =
      isSuccess ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);

  Get.closeAllSnackbars();

  Get.snackbar(
    '',
    '',
    titleText: Column(
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
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                )
                : Icon(
                  isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
                  color: primaryColor,
                  size: 24.sp,
                ),
          ],
        ),
        SizedBox(height: 8.h),
      ],
    ),
    messageText: Padding(
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
    backgroundColor: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
    padding: EdgeInsets.only(left: 8.w, right: 16.w, top: 16.h, bottom: 16.h),
    animationDuration: const Duration(milliseconds: 350),
    forwardAnimationCurve: Curves.easeOutCubic,
    reverseAnimationCurve: Curves.easeInCubic,
    duration:
        isLoading ? const Duration(seconds: 10) : const Duration(seconds: 4),
    shouldIconPulse: false,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 16,
        spreadRadius: 0,
        offset: const Offset(0, 6),
      ),
    ],
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 16.r,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    borderWidth: 0,
    overlayBlur: 0.8,
    overlayColor: Colors.black.withOpacity(0.05),
  );
}
