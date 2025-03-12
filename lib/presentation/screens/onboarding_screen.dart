import '/routes.dart';
import 'package:gap/gap.dart';
import '/utils/app_colors.dart';
import '/utils/extensions.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:quick_ride_user/di.dart';
import 'package:go_router/go_router.dart';
import '/presentation/widget/app_button.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: context.height - 250,
            child: Image.asset(
              'assets/jpg/onboarding-1.jpg',
              height: context.height - 250,
              width: context.width,
              fit: BoxFit.cover,
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
                    'assets/png/full-transparent-white-logo.png',
                    height: 28,
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
                    title: 'Get Started',
                    radius: 8,
                    height: 50,
                    textStyle: context.textTheme.headlineMedium?.copyWith(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w500,
                    ),
                    onTap: () {
                      prefs.setBool(PrefKeys.showWalkThru, false);
                      context.pushReplacementNamed(RouteConsts.index);
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
