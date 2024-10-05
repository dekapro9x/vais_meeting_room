import 'package:app_base_flutter/configs/global_colors.dart';
import 'package:app_base_flutter/configs/global_size_responsive_configs.dart';
import 'package:app_base_flutter/models/intro/onboarding_data.dart';
import 'package:app_base_flutter/routers//route_generator.dart';
import 'package:app_base_flutter/widgets/app_big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 8),
      duration: const Duration(milliseconds: 400),
      height: 8,
      width: currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? GlobalColors.primaryColor
            : GlobalColors.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigResponsiveApp sizeConfigReponsive =
        SizeConfigResponsiveApp(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                flex: 3, //3 màn flex = 1
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onboardingContents
                      .length, 
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      currentPage == onboardingContents.length - 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    navigator!.pushNamedAndRemoveUntil(
                                        RouteGenerator.policy,
                                        (route) => false);
                                  },
                                  borderRadius: BorderRadius.circular(6),
                                  splashColor: Colors.transparent,
                                  child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: AppBigText(
                                        text: 'Skip',
                                        size: 16,
                                        fontWeight: FontWeight.w800,
                                        color: GlobalColors.primaryColor,
                                      )),
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        height: sizeConfigReponsive.getHeightResponsive(32),
                      ),
                      SizedBox(
                        child: Image.asset(
                          onboardingContents[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: sizeConfigReponsive.getWidthReposive(24),
                      ),
                      AppBigText(
                        text: onboardingContents[index].title,
                        size: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: sizeConfigReponsive.getWidthReposive(16),
                      ),
                      AppBigText(
                        text: onboardingContents[index].subtitle,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.kGreyTextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    currentPage == onboardingContents.length - 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              currentPage == 0
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        _pageController.previousPage(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: sizeConfigReponsive
                                            .getWidthReposive(48),
                                        height: sizeConfigReponsive
                                            .getWidthReposive(48),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                sizeConfigReponsive
                                                    .getWidthReposive(46)),
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                    GlobalColors.primaryColor)),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: GlobalColors.primaryColor,
                                        ),
                                      ),
                                    ),
                              Row(
                                children: List.generate(
                                  onboardingContents.length,
                                  (index) => dotIndicator(index),
                                ),
                              ),
                              SizedBox.fromSize(
                                size: const Size(48, 48),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              currentPage != 0
                                  ? GestureDetector(
                                      onTap: () {
                                        _pageController.previousPage(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: sizeConfigReponsive
                                            .getWidthReposive(48),
                                        height: sizeConfigReponsive
                                            .getWidthReposive(48),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                sizeConfigReponsive
                                                    .getWidthReposive(46)),
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                    GlobalColors.primaryColor)),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: GlobalColors.primaryColor,
                                        ),
                                      ),
                                    )
                                  : SizedBox.fromSize(
                                      size: const Size(48, 48),
                                    ),
                              Row(
                                children: List.generate(
                                  onboardingContents.length,
                                  (index) => dotIndicator(index),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _pageController.nextPage(
                                    duration: const Duration(
                                      milliseconds: 400,
                                    ),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  width:
                                      sizeConfigReponsive.getWidthReposive(48),
                                  height:
                                      sizeConfigReponsive.getWidthReposive(48),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        sizeConfigReponsive
                                            .getWidthReposive(45)),
                                    color: GlobalColors.primaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: sizeConfigReponsive.getHeightResponsive(32),
                    ),
                    currentPage == onboardingContents.length - 1
                        ? GestureDetector(
                            onTap: () {
                              navigator!.pushNamedAndRemoveUntil(
                                  RouteGenerator.bottomNavigationBar, (route) => false);
                            },
                            child: Container(
                                height:
                                    sizeConfigReponsive.getHeightResponsive(47),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: GlobalColors.primaryColor,
                                    borderRadius: BorderRadius.circular(
                                        sizeConfigReponsive
                                            .getWidthReposive(39))),
                                child: Center(
                                  child: AppBigText(
                                    text: 'Vào trang chủ'.tr,
                                    size: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )),
                          )
                        : Container(
                            height: sizeConfigReponsive.getHeightResponsive(47),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
