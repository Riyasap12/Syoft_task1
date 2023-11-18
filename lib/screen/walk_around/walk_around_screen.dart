import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syoft_task/constant/common.dart';
import 'package:syoft_task/constant/extensions.dart';
import 'package:syoft_task/core/shared_preference/shared_preference_repo.dart';
import 'package:syoft_task/screen/auth/auth.dart';

class WalkaroundScreen extends StatefulWidget {
  const WalkaroundScreen({super.key});

  @override
  State<WalkaroundScreen> createState() => _WalkaroundScreenState();
}

class _WalkaroundScreenState extends State<WalkaroundScreen> {
  List<Map<String, dynamic>> wData = [
    {
      "image": imageAssets.walkAround1,
      "title": "Order Your Food",
      "subTitle": "Now you can order food anytime right from your mobile",
      "height": 283.h,
      "width": 295.h,
      "padding": 65.h
    },
    {
      "image": imageAssets.walkAround2,
      "title": "Cooking Safe Food",
      "subTitle": "We are maintain safty and We keep clean while making food",
      "height": 283.h,
      "width": 327.h,
      "padding": 39.h
    },
    {
      "image": imageAssets.walkAround3,
      "title": "Quick Delivery",
      "subTitle": "Order your favourate meals will be immediate deliver",
      "height": 308.h,
      "width": 256.h,
      "padding": 26.h
    }
  ];
  final PageController pageController = PageController(initialPage: 0);
  RxInt currentIndex = 0.obs;
  double? currentPageValue = 0;
  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
      });
    });
    super.initState();
  }

  List<List<Color>> colorSet = const [
    [Color(0xff9FF2F3), Color(0xffF1FDFD), Color(0xffffff)],
    [Color(0xffF8C2CC), Color(0xffFBDFE4), Color(0xffffff)],
    [Color(0xffCAF5BA), Color(0xffE5FADE), Color(0xffffff)]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 380.h,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffFDE4B9), Colors.white.withOpacity(0)],
                            begin: Alignment.topCenter,
                            stops: [0, 2],
                            end: Alignment.bottomCenter)),
                  ))),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(() {
                    currentIndex.value;
                    return AnimatedContainer(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: colorSet[currentIndex.value],
                              begin: Alignment.bottomCenter,
                              // stops: [0, 2],
                              end: Alignment.topCenter)),
                      duration: const Duration(milliseconds: 300),
                    );
                  }))),
          Positioned(
            right: 16.h,
            top: MediaQuery.of(context).padding.top + 12.h,
            child: (currentIndex.value == 2)
                ? const Offstage()
                : InkWell(
                    onTap: () {
                      currentIndex.value = 2;
                      pageController.animateToPage(2,
                          duration: Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Text("Skip",
                        style: TextStyle(fontSize: 14.h, color: Color(0xff2F3541), fontWeight: FontWeight.w600)),
                  ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(imageAssets.wBack, fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 78.h,
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: wData.length,
                  onPageChanged: (value) {
                    currentIndex.value = value;
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: wData[index]['padding']),
                        (index == 1) ? titleAndSubTitle(index) : imageData(index),
                        const Spacer(),
                        (index == 1) ? imageData(index) : titleAndSubTitle(index),
                      ],
                    );
                  },
                ),
              ),
              44.sbh,
              SizedBox(
                height: 160.h,
                child: Column(
                  children: [
                    // 80.sbh,
                    const Spacer(),
                    Obx(() {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 12.h,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      3,
                                      (index) => Obx(() {
                                            return AnimatedContainer(
                                              height: 6.h,
                                              width: 6.h,
                                              margin: EdgeInsets.symmetric(horizontal: 3.h),
                                              decoration: BoxDecoration(
                                                  color: (currentIndex == index) ? kColors.dark1 : Colors.white,
                                                  shape: BoxShape.circle),
                                              duration: const Duration(milliseconds: 300),
                                            );
                                          }))),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (currentIndex.value == 2) {
                                  SharedPreferenceRepo.instance.isFirstTimeUser = false;
                                  Get.to(() => AuthScreen());
                                } else {
                                  pageController.animateToPage(currentIndex.value + 1,
                                      duration: const Duration(milliseconds: 300), curve: Curves.linear);
                                }
                              },
                              child: Container(
                                  height: 60.h,
                                  width: 60.h,
                                  decoration: BoxDecoration(color: kColors.dark1, shape: BoxShape.circle),
                                  child: Center(
                                      child: Text((currentIndex.value == 2) ? "Start" : "Next",
                                          style: TextStyle(
                                              fontSize: 12.h, fontWeight: FontWeight.w900, color: Colors.white)))),
                            ),
                          ],
                        ),
                      );
                    }),
                    32.sbh
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget imageData(int index) {
    return Center(
        child: Image.asset(wData[index]['image'],
            height: wData[index]['height'], fit: BoxFit.fill, width: wData[index]['width']));
  }

  Widget titleAndSubTitle(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            wData[index]['title'],
            style: GoogleFonts.poppins(fontSize: 24.h, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          12.sbh,
          Text(
            wData[index]['subTitle'],
            style: TextStyle(fontSize: 16.h),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
