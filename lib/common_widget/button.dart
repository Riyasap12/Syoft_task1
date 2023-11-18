import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/common.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      this.buttonColor,
      this.child,
      this.fontWeight,
      this.textSize,
      this.elevation,
      this.height,
      this.onPressed,
      this.textColor,
      this.borderColor,
      this.borderRadius,
      this.width})
      : super(key: key);
  final double? elevation;
  final double? textSize;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? buttonColor;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Widget? child;
  final String text;
  final Color? borderColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      highlightColor: Colors.transparent,
      hoverColor: Colors.red,
      elevation: elevation ?? 0,
      disabledColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.h),
          side: (borderColor != null) ? BorderSide(color: borderColor!, width: 1) : BorderSide.none),
      height: height ?? 48.h,
      color: buttonColor ?? kColors.green,
      minWidth: width ?? (Get.mediaQuery.size.width * 0.4),
      onPressed: onPressed,
      textColor: textColor ?? kColors.dark1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: textSize ?? 12.h,
                color: textColor ?? Colors.white,
                letterSpacing: 1,
                fontWeight: fontWeight ?? FontWeight.bold),
          ),
          if (child != null)
            SizedBox(
              width: 4.h,
            ),
          child ?? const Offstage(),
        ],
      ),
    );
  }
}
