import 'package:gap/gap.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:x_ride_user/utils/app_colors.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:timeline_tile_plus/timeline_tile_plus.dart';

class UpcomingRideItem extends StatelessWidget {
  const UpcomingRideItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.tertiary),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 46,
              width: context.width,
              color: AppColors.red.withValues(alpha: .17),
              child: Text(
                '🕔 Ride in 15 Min',
                style: context.textTheme.headlineSmall?.copyWith(
                  color: AppColors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
                  Text(
                    'Monday 22 Feb, 1:23PM',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Economy',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(12),
                  divider,
                  const Gap(12),
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    // isFirst: true,
                    indicatorStyle: IndicatorStyle(
                      color: const Color.fromARGB(255, 249, 109, 109),
                    ),
                    afterLineStyle: LineStyle(
                      color: const Color.fromARGB(255, 248, 132, 132),
                    ),
                    beforeLineStyle: LineStyle(
                      color: const Color.fromARGB(255, 248, 132, 132),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'PICK-UP',
                            style: context.textTheme.labelLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.red,
                            ),
                          ),
                          Text(
                            'Father Patrick Lynch Street, Low Cost Estate, '
                            'Goaso, Asunafo North Municipal District, Ahafo '
                            'Region, BU-0003-8544, Ghana',
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(14),
                        ],
                      ),
                    ),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    // isLast: true,
                    beforeLineStyle: LineStyle(
                      color: const Color.fromARGB(255, 247, 103, 103),
                    ),
                    afterLineStyle: LineStyle(
                      color: const Color.fromARGB(255, 247, 103, 103),
                    ),
                    indicatorStyle: IndicatorStyle(color: AppColors.red),
                    endChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'DROP-OFF',
                            style: context.textTheme.labelLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.red,
                            ),
                          ),
                          Text(
                            'Father Patrick Lynch Street, Low Cost Estate, '
                            'Goaso, Asunafo North Municipal District, Ahafo '
                            'Region, BU-0003-8544, Ghana',
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(14),
                        ],
                      ),
                    ),
                  ),
                  const Gap(12),
                  divider,
                  const Gap(12),
                  Text(
                    '₵91-18',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 22,
                      color: context.colors.primary,
                    ),
                  ),
                  Text(
                    'This is just an approximate fare, cost may differ.',
                    style: context.textTheme.labelSmall,
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
