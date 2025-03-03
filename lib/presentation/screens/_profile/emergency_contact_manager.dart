import 'package:gap/gap.dart';
import '../../widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';

class EmergencyContactManager extends StatefulWidget {
  const EmergencyContactManager({super.key});

  @override
  State<EmergencyContactManager> createState() =>
      _EmergencyContactManagerState();
}

class _EmergencyContactManagerState extends State<EmergencyContactManager> {
  final String name = 'Alex Dickson';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'profile.emergencyContactsManager'.tr(),
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    const Gap(24),
                    Text(
                      'profile.emergencyContactsManagerDesc'.tr(args: [name]),
                      style: context.textTheme.labelMedium,
                    ),
                    const Gap(36),
                    ListTile(
                      leading: RandomAvatar(
                        'saytoonz',
                        width: 60,
                        height: 60,
                      ),
                      title: Text(
                        name,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        '0208 457 888',
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall,
                      ),
                    ),
                    Divider(
                      height: 12,
                      color: context.colors.tertiary,
                    ),
                    const Gap(18),
                    AppButton(
                      title: 'Every trip',
                      isNegative: true,
                      borderColor: context.colors.tertiary,
                      textStyle: context.textTheme.labelLarge,
                      onTap: () {},
                    ),
                    const Gap(12),
                    AppButton(
                      title: 'At Night [9PM - 6AM]',
                      isNegative: true,
                      borderColor: context.colors.tertiary,
                      textStyle: context.textTheme.labelLarge,
                      onTap: () {},
                    ),
                    const Gap(12),
                    AppButton(
                      title: 'I\'ll share it Manually',
                      isNegative: true,
                      borderColor: context.colors.tertiary,
                      textStyle: context.textTheme.labelLarge,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppButton(
                title: 'shared.done',
                radius: 8,
                onTap: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
