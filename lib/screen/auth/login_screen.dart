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
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/constant/extensions.dart';
import 'package:syoft_task/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  RxBool isViewPassword = false.obs;

  AuthController controller = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

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
              TextSpan(text: "Welcome Back"),
              TextSpan(text: "\nRebecca", style: TextStyle(fontWeight: FontWeight.bold)),
            ])),
            48.sbh,
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
                  passwordFocus.unfocus();
                  submitFunction();
                },
                suffixIcon: IconButton(
                  icon: Icon((isViewPassword.value) ? Icons.visibility : Icons.visibility_off),
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
                return (controller.isLogin)
                    ? SizedBox(height: 45.h, width: 72.h, child: const CustomProgressIndicator())
                    : InkWell(
                        onTap: () {
                          submitFunction();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 199, 116), borderRadius: BorderRadius.circular(8.h)),
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
          Positioned.fill(
            left: 30.h,
            bottom: 30.h,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }

  submitFunction() async {
    _formKey.currentState!.save();
    if (_formKey.currentState?.validate() == true) {
      await controller.login(email: emailController.text, passWord: passwordController.text);
    }
  }
}
