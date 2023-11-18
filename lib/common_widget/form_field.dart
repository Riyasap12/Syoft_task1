import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syoft_task/constant/common.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.controller,
      required this.hint,
      this.isPassword = false,
      this.minLines = 1,
      this.onChanged,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.maxLength,
      this.initialValue,
      this.readOnly,
      this.borderColor,
      this.borderRadius,
      this.focusNode,
      this.onSubmitted,
      this.validator})
      : super(key: key);
  final String hint;
  final String? initialValue;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSubmitted;
  final TextEditingController? controller;
  final int minLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? borderColor;
  final double? borderRadius;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final border = UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.h),
        borderSide: BorderSide(color: borderColor ?? kColors.lite2, width: 2.h));

    return TextFormField(
        enabled: readOnly ?? true,
        readOnly: readOnly ?? false,
        focusNode: focusNode,
        initialValue: initialValue,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        maxLines: minLines,
        controller: controller,
        obscureText: isPassword,
        maxLength: maxLength ?? 50,
        style: TextStyle(color: kColors.dark1, fontSize: 16.h, fontWeight: FontWeight.w600),
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: hint,
          counterText: "",
          suffixIcon: suffixIcon,
          labelStyle: TextStyle(fontSize: 14.h, color: Color(0xffB4B4B4), fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 10.h),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: border,
          border: border,
          enabledBorder: border,
          errorBorder: border.copyWith(borderSide: BorderSide(color: kColors.red, width: 1.h)),
          focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: kColors.red, width: 1.h)),
        ));
  }
}
