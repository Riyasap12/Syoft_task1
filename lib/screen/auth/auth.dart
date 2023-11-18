import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/constant/extensions.dart';
import 'package:syoft_task/screen/auth/login_screen.dart';
import 'package:syoft_task/screen/auth/register_screen.dart';

import '../../controller/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthController controller = Get.put(AuthController());
  final PageController pageController = PageController(initialPage: 0);
  RxInt currentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Obx(() {
                currentIndex.value;
                return Row(
                  children: [
                    loginOption(name: "Login", index: 0),
                    24.sbw,
                    loginOption(name: "Sign Up", index: 1),
                    const Spacer(),
                    Container(
                      height: 50.h,
                      width: 50.h,
                      padding: EdgeInsets.all(6.h),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColors.lite1,
                          boxShadow: [BoxShadow(color: kColors.lite1, spreadRadius: 8.h, blurRadius: 6.h)],
                          border: Border.all(width: 3.h, color: Colors.white)),
                      child: Image.asset(imageAssets.logo),
                    ),
                  ],
                );
              }),
            ]),
          ),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [LoginScreen(), RegisterScreen()],
          )),
          // Spacer(),
        ],
      ),
    );
  }

  double getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }

  Widget loginOption({required String name, required int index}) {
    return GestureDetector(
      onTap: () {
        currentIndex.update((val) {
          currentIndex.value = index;
        });
        pageController.jumpToPage(index);
      },
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14.h,
            ),
          ),
          6.sbh,
          Container(
            width: getTextWidth(
                name,
                TextStyle(
                  fontSize: 14.h,
                )),
            height: 1.h,
            color: (currentIndex.value == index) ? kColors.blueDark : Colors.transparent,
          )
        ],
      ),
    );
  }
}
