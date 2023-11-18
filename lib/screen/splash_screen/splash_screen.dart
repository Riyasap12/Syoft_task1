import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/core/shared_preference/shared_preference_repo.dart';
import 'package:syoft_task/screen/home/home.dart';
import '../walk_around/walk_around_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 3), () {
        if (SharedPreferenceRepo.instance.isLoggedIn == true) {
          Get.off(() => MainScreen());
        } else if (SharedPreferenceRepo.instance.isFirstTimeUser == true) {
          Get.off(() => const WalkaroundScreen());
        } else {
          // For testing we are redirecting to walkaround screen
          Get.off(() => const WalkaroundScreen());
          // Get.off(() => const AuthScreen());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9FF2F3),
      body: Center(
        child: Image.asset(
          imageAssets.logo,
          height: 80.h,
          width: 276.h,
        ),
      ),
    );
  }
}
