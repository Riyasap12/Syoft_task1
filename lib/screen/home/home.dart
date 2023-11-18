import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syoft_task/common_widget/button.dart';
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/constant/extensions.dart';
import 'package:syoft_task/core/shared_preference/shared_preference_repo.dart';
import 'package:syoft_task/screen/walk_around/walk_around_screen.dart';

class MainScreen extends StatelessWidget {
  int? index;
  MainScreen({super.key, this.index});

  RxInt currentIndex = 0.obs;

  final PageController pageController = PageController(initialPage: 0);

  final user = SharedPreferenceRepo.instance.userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
          // color: kColors.green,
          child: CustomButton(
            text: "Logout",
            onPressed: () {
              SharedPreferenceRepo.instance.logout();
              Get.offAll(() => const WalkaroundScreen());
            },
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          50.sbh,
          RichText(
              text: TextSpan(style: TextStyle(fontSize: 26.h, color: kColors.dark1, height: 1.2), children: [
            const TextSpan(text: "Welcome Back"),
            TextSpan(
                text: "\n${"${user?.firstName ?? ""} ${user?.lastName ?? ""}"}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ])),
          48.sbh,
        ]),
      ),
    );
  }
}
