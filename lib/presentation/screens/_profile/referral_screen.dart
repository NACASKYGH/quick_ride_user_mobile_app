import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:x_ride_user/utils/app_colors.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final String referralCode = 'saytoonz05';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'profile.referralCode'.tr(),
          style: context.textTheme.headlineSmall,
        ),
        actions: [
          AppButton(
            title: 'profile.enterCode',
            width: 130,
            isNegative: true,
          ),
          const Gap(12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Gap(24),
            Container(
              height: 180,
              width: context.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'profile.inviteWithCode'.tr(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                  ),
                  const Gap(24),
                  AppButton(
                    width: context.width * .5,
                    height: 52,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share,
                        size: 32,
                        color: AppColors.white,
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share,
                        color: AppColors.transparent,
                      ),
                    ),
                    title: referralCode,
                    translateText: false,
                    radius: 8,
                    onTap: () {
                      Share.share(
                        'profile.shareCodeDesc'.tr(args: [referralCode]),
                        subject: 'profile.shareCodeTitle'.tr(),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(38),
            Text(
              'No referral bonus received',
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall?.copyWith(
                fontSize: 16,
              ),
            ),
            const Gap(12),
            Text(
              'Share the referral link to maximum number of people, '
              'once they joined, both of you will receive bonus.',
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
