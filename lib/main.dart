import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/screen/splash_screen/splash_screen.dart';
import 'core/shared_preference/shared_preference_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferenceRepo.initialize();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(376, 813),
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            title: 'Syoft Task',
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            theme: ThemeData(
                hoverColor: Colors.transparent,
                canvasColor: Colors.transparent,
                // canvasColor: Colors.transparent,
                scaffoldBackgroundColor: Colors.white,
                splashColor: Colors.grey.withOpacity(.1),
                highlightColor: Colors.transparent,
                splashFactory: InkRipple.splashFactory,
                textTheme: GoogleFonts.poppinsTextTheme(),
                appBarTheme: AppBarTheme(
                    elevation: 0,
                    toolbarHeight: 56.h,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black.withOpacity(.2),
                    titleTextStyle: TextStyle(fontSize: 14.h, color: kColors.dark1),
                    iconTheme: IconTheme.of(context).copyWith(color: kColors.dark1),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      systemNavigationBarIconBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.dark,
                    ))),
            home: const SplashScreen(),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
