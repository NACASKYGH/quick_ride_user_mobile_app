import '/utils/extensions.dart';
import '../../utils/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_ride_user/routes.dart';
import '/presentation/notifiers/ui_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:quick_ride_user/presentation/notifiers/auth_notifier.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({
    super.key,
    required this.showPathWayBadge,
  });

  final bool showPathWayBadge;

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    UiNotifier uiNotifier = context.watch<UiNotifier>();
    AuthNotifier authNotifier = context.watch<AuthNotifier>();

    bool isLoggedIn = authNotifier.appUser != null;

    final double additionalBottomPadding =
        MediaQuery.of(context).viewPadding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.blackText : AppColors.lightBg,
        border: Border(
          top: BorderSide(
            color: context.isDarkMode ? AppColors.grey : AppColors.secondary,
          ),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: kBottomNavigationBarHeight + additionalBottomPadding,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: EdgeInsets.only(bottom: additionalBottomPadding),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: DefaultTextStyle.merge(
              overflow: TextOverflow.ellipsis,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _BottomNavItem(
                    asset: 'assets/svg/nav-home',
                    label: 'index.home'.tr(),
                    isActive: uiNotifier.indexTabIndex == 0,
                    onTap: () => uiNotifier.indexTabIndex = 0,
                  ),
                  _BottomNavItem(
                    asset: 'assets/svg/nav-explore',
                    label: 'index.trips'.tr(),
                    isActive: uiNotifier.indexTabIndex == 1,
                    onTap: () => !isLoggedIn
                        ? context.pushNamed(RouteConsts.phoneScreen)
                        : uiNotifier.indexTabIndex = 1,
                  ),
                  _BottomNavItem(
                    asset: 'assets/svg/nav-profile',
                    label: 'index.profile'.tr(),
                    badgeCount: 0,
                    isActive: uiNotifier.indexTabIndex == 2,
                    onTap: () => !isLoggedIn
                        ? context.pushNamed(RouteConsts.phoneScreen)
                        : uiNotifier.indexTabIndex = 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String asset;
  final String label;

  final bool isActive;

  final VoidCallback onTap;
  final int badgeCount;

  const _BottomNavItem({
    required this.asset,
    required this.label,
    required this.onTap,
    this.badgeCount = 0,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 3),
          Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(
                '$asset${isActive ? '-active' : ''}.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isActive ? context.colors.inverseSurface : AppColors.grey,
                  BlendMode.srcIn,
                ),
              ),
              Visibility(
                visible: badgeCount > 0,
                child: Container(
                  height: 8,
                  width: 8,
                  margin: const EdgeInsets.only(top: 3, right: 0),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: AppColors.lightBg,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 70,
            child: Center(
              child: Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  color:
                      isActive ? context.colors.inverseSurface : AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
