import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syoft_task/constant/common.dart';

enum SnackBarType { info, error, success }

customSnackBar({
  SnackBarType? snackBarType,
  required String message,
  // String? title,
}) {
  String icon;
  SnackBarType snackBar = snackBarType ?? SnackBarType.error;
  switch (snackBar) {
    case SnackBarType.error:
      snackBarType = SnackBarType.error;
      icon = iconAssets.error;
      break;
    case SnackBarType.success:
      snackBarType = SnackBarType.success;
      icon = iconAssets.success;
      break;
    case SnackBarType.info:
      snackBarType = SnackBarType.info;
      icon = iconAssets.info;
      break;
  }
  return ScaffoldMessenger.of(Get.context!)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
      content: Row(
        children: [
          SvgPicture.asset(icon, height: 40.h, color: Colors.white),
          SizedBox(width: 16.h),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
    ));
}
