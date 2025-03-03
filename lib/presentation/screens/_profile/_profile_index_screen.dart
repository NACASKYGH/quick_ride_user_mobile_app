import '/routes.dart';
import 'package:gap/gap.dart';
import '/utils/app_colors.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../widget/circular_icon_btn.dart';
import '/presentation/notifiers/ui_notifier.dart';
import '../../widget/profile_image_with_rating.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class ProfileIndexScreen extends StatefulWidget {
  const ProfileIndexScreen({super.key});

  @override
  State<ProfileIndexScreen> createState() => _ProfileIndexScreenState();
}

class _ProfileIndexScreenState extends State<ProfileIndexScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget dividerTertiary = Divider(
      height: 16,
      color: context.colors.tertiary,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.transparent,
        title: Text(
          'index.profile'.tr(),
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.whiteText,
          ),
        ),
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: CircularIconBtn(
            bgColor: AppColors.transparent,
            showShadow: false,
            icon: Icon(Icons.close, size: 30, color: AppColors.white),
            onTap: () => context.read<UiNotifier>().indexTabIndex = 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              height: 270,
              width: context.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [.4, 1],
                  colors: [
                    context.colors.primary,
                    context.colors.primary.withValues(alpha: .7),
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: () => context.pushNamed(RouteConsts.editProfile),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Abu National',
                                overflow: TextOverflow.ellipsis,
                                style:
                                    context.textTheme.headlineLarge?.copyWith(
                                  color: AppColors.whiteText,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                '+233 208 457 888',
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: AppColors.whiteText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(12),
                        const ProfileImageWithRating(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              controller: _scrollController,
              shrinkWrap: true,
              children: [
                const Gap(12),
                ListItem(
                  title: 'Add Home',
                  icon: Icons.home,
                  onTap: () {
                    context.pushNamed(
                      RouteConsts.addLocation,
                      extra: 'profile.addHome'.tr(),
                    );
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Add Work',
                  icon: Icons.work,
                  onTap: () {
                    context.pushNamed(
                      RouteConsts.addLocation,
                      extra: 'profile.addWork'.tr(),
                    );
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Saved Places',
                  icon: Icons.location_pin,
                  onTap: () {
                    context.pushNamed(RouteConsts.savePlaces);
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Promos',
                  icon: Icons.sell,
                  onTap: () {
                    context.pushNamed(RouteConsts.promoScreen);
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Referral Code',
                  icon: Icons.people_alt,
                  onTap: () {
                    context.pushNamed(RouteConsts.referralCodeScreen);
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Emergency Contact',
                  icon: Icons.call,
                  onTap: () {
                    context.pushNamed(RouteConsts.emergencyContacts);
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Logout',
                  icon: Icons.logout,
                  textColor: AppColors.red,
                  onTap: () async {
                    final result = await FlutterPlatformAlert.showCustomAlert(
                      windowTitle: 'Attention!',
                      text: 'Do you want to logout from this device?',
                      positiveButtonTitle: 'Yes',
                      negativeButtonTitle: 'Cancel',
                    );
                    if (!context.mounted) return;
                    if (result == CustomButton.positiveButton) {
                      context.goNamed(RouteConsts.splash);
                    }
                  },
                ),
                dividerTertiary,
                ListItem(
                  title: 'Delete Account',
                  icon: Icons.delete_forever,
                  textColor: AppColors.red,
                  onTap: () async {
                    final result = await FlutterPlatformAlert.showCustomAlert(
                      windowTitle: 'Attention!',
                      text:
                          'Is this what you want to do?\nDeleting your account?',
                      positiveButtonTitle: 'Yes',
                      negativeButtonTitle: 'No',
                    );
                    if (!context.mounted) return;
                    if (result == CustomButton.positiveButton) {
                      context.goNamed(RouteConsts.splash);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.textColor,
  });
  final String title;
  final String? subtitle;
  final IconData icon;
  final Function()? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor,
      ),
      title: Text(
        title,
        style: context.textTheme.labelLarge?.copyWith(
          fontSize: 18,
          color: textColor,
        ),
      ),
      subtitle: (subtitle ?? '').isNotEmpty
          ? Text(
              subtitle ?? '',
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall,
            )
          : null,
      onTap: onTap,
    );
  }
}
