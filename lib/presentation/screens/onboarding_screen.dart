import 'dart:async';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:x_ride_user/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:x_ride_user/utils/app_colors.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int delayInSecs = 3;
  late int countDownInt = delayInSecs;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        timer = t;
        Duration duration = const Duration(milliseconds: 500);
        Curve curve = Curves.easeIn;
        if (countDownInt == 0) {
          if (_pageController.page == 3) {
            // _pageController.jumpTo(0);
            _pageController.animateToPage(0, duration: duration, curve: curve);
          } else {
            _pageController.nextPage(duration: duration, curve: curve);
          }
          countDownInt = delayInSecs;
        } else {
          countDownInt--;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: context.height - 250,
            child: PageView(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  countDownInt = delayInSecs;
                });
              },
              children: [
                Image.asset(
                  'assets/jpg/onboarding-1.jpg',
                  height: context.height - 250,
                  width: context.width,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/jpg/onboarding-2.jpg',
                  height: context.height - 250,
                  width: context.width,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/jpg/onboarding-3.jpg',
                  height: context.height - 250,
                  width: context.width,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/jpg/onboarding-4.webp',
                  height: context.height - 250,
                  width: context.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            width: context.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.darkBg,
                  AppColors.darkBg.withValues(alpha: .7),
                  AppColors.darkBg.withValues(alpha: .4),
                  AppColors.darkBg.withValues(alpha: .2),
                  AppColors.darkBg.withValues(alpha: .01),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: context.height,
              width: context.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkBg.withValues(alpha: .01),
                    AppColors.darkBg.withValues(alpha: .01),
                    AppColors.darkBg.withValues(alpha: .2),
                    AppColors.darkBg.withValues(alpha: .4),
                    AppColors.darkBg.withValues(alpha: .7),
                    AppColors.darkBg,
                    AppColors.darkBg,
                    AppColors.darkBg,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/png/logo-green.png',
                    height: 48,
                  ),
                  const Gap(12),
                  Text(
                    'onboarding.title'.tr(),
                    textAlign: TextAlign.start,
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 32,
                      color: AppColors.whiteText,
                    ),
                  ),
                  const Gap(26),
                  Text(
                    'onboarding.description'.tr(),
                    textAlign: TextAlign.start,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: AppColors.whiteText,
                    ),
                  ),
                  const Gap(58),
                  AppButton(
                    isGradient: true,
                    title: 'onboarding.btnText',
                    radius: 8,
                    height: 50,
                    textStyle: context.textTheme.headlineMedium?.copyWith(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w500,
                    ),
                    onTap: () {
                      context.pushReplacementNamed(RouteConsts.phoneScreen);

                      //TODO: Uncomment the code below
                      // prefs.setBool(PrefKeys.showWalkThru, false);
                    },
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
