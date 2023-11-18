import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syoft_task/common_widget/button.dart';
import 'package:syoft_task/common_widget/form_field.dart';
import 'package:syoft_task/common_widget/progress_indicator.dart';
import 'package:syoft_task/common_widget/snck_bar.dart';
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/constant/extensions.dart';
import 'package:syoft_task/controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  RxBool isViewPassword = false.obs;
  RxBool isViewConfirmPassword = false.obs;

  AuthController controller = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode mobileNumberFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            50.sbh,
            RichText(
                text: TextSpan(style: TextStyle(fontSize: 26.h, color: kColors.dark1, height: 1.2), children: const [
              TextSpan(text: "Hello "),
              TextSpan(text: "Beautiful,", style: TextStyle(fontWeight: FontWeight.bold)),
            ])),
            8.sbh,
            Text(
              "Enter your information below or login with a social account",
              style: TextStyle(fontSize: 16.h),
            ),
            48.sbh,
            CustomTextFormField(
              hint: "First Name",
              controller: firstNameController,
              focusNode: firstNameFocus,
              validator: (value) {
                if ((value ?? "").trim().length < 4) {
                  return "Name should be 4 characters";
                }
                return null;
              },
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[0-9]'))],
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(emailFocus);
              },
            ),
            16.sbh,
            CustomTextFormField(
              hint: "Email Address",
              controller: emailController,
              focusNode: emailFocus,
              validator: (value) {
                if (GetUtils.isEmail(value ?? "") == false) {
                  return "Enter valid Email";
                } else {
                  return null;
                }
              },
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(mobileNumberFocus);
              },
            ),
            16.sbh,
            CustomTextFormField(
              hint: "Mobile Number",
              controller: mobileNumberController,
              focusNode: mobileNumberFocus,
              maxLength: 10,
              validator: (value) {
                if ((value ?? "").trim().length != 10) {
                  return "Enter valid mobile number";
                }
                return null;
              },
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
            16.sbh,
            Obx(() {
              isViewPassword.value;
              return CustomTextFormField(
                hint: "Password",
                controller: passwordController,
                isPassword: !isViewPassword.value,
                validator: (value) {
                  if ((value ?? "").length < 4) {
                    return "Password should be 4 characters";
                  }
                  return null;
                },
                focusNode: passwordFocus,
                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(confirmPasswordFocus);
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    (isViewPassword.value) ? Icons.visibility : Icons.visibility_off,
                  ),
                  iconSize: 20.h,
                  color: kColors.dark2,
                  onPressed: () {
                    isViewPassword.update((val) {
                      isViewPassword.value = !isViewPassword.value;
                    });
                    log(isViewPassword.toString());
                  },
                ),
              );
            }),
            16.sbh,
            Obx(() {
              isViewConfirmPassword.value;
              return CustomTextFormField(
                hint: "Confirm Password",
                controller: confirmPasswordController,
                isPassword: !isViewConfirmPassword.value,
                validator: (value) {
                  if ((value ?? "").length < 4) {
                    return "Password should be 4 characters";
                  }
                  return null;
                },
                focusNode: confirmPasswordFocus,
                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                onSubmitted: (value) {
                  confirmPasswordFocus.unfocus();
                  submitFunction();
                },
                suffixIcon: IconButton(
                  icon: Icon((isViewConfirmPassword.value) ? Icons.visibility : Icons.visibility_off),
                  color: kColors.dark2,
                  iconSize: 20.h,
                  onPressed: () {
                    isViewConfirmPassword.update((val) {
                      isViewConfirmPassword.value = !isViewConfirmPassword.value;
                    });
                  },
                ),
              );
            }),
            16.sbh,
            Row(
              children: [
                SvgPicture.asset(
                  iconAssets.google,
                  height: 22.h,
                  width: 22.h,
                ),
                4.sbw,
                SvgPicture.asset(
                  iconAssets.facebook,
                  height: 14.h,
                  width: 14.h,
                ),
              ],
            ),
            60.sbh,
          ]),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          SizedBox(
            height: 120.h,
            child: Column(children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 150, 186, 175),
                ),
              ),
            ]),
          ),
          Positioned.fill(
            right: 30.h,
            child: Align(
              alignment: Alignment.centerRight,
              child: GetBuilder<AuthController>(builder: (_) {
                return (controller.isRegisteriying)
                    ? SizedBox(height: 45.h, width: 72.h, child: const CustomProgressIndicator())
                    : InkWell(
                        onTap: () {
                          submitFunction();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 113, 94), borderRadius: BorderRadius.circular(8.h)),
                          height: 45.h,
                          width: 72.h,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 24.h,
                            color: Colors.white,
                          ),
                        ),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }

  submitFunction() async {
    _formKey.currentState!.save();
    if (_formKey.currentState?.validate() == true) {
      if (passwordController.text == confirmPasswordController.text) {
        await controller.register(
            email: emailController.text,
            password: passwordController.text,
            firstName: firstNameController.text,
            mobileNumber: mobileNumberController.text);
      } else {
        customSnackBar(message: "Password doesn't match");
      }
    }
  }
}
