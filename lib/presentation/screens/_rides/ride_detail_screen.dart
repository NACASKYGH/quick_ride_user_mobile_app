import 'package:gap/gap.dart';
import '/utils/app_colors.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import '../../widget/circular_icon_btn.dart';
import 'package:flutter_map/flutter_map.dart';
import '/presentation/widget/image_loader.dart';
import '/presentation/notifiers/ui_notifier.dart';
import 'package:timeline_tile_plus/timeline_tile_plus.dart';

class RideDetailScreen extends StatefulWidget {
  const RideDetailScreen({super.key});

  @override
  State<RideDetailScreen> createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends State<RideDetailScreen> {
  final double mapHeight = 340;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_listener);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    context.read<UiNotifier>().rideDetailScrollPos =
        _scrollController.position.pixels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: mapHeight,
            width: context.width,
            color: Colors.red,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(50.5, 30.51),
                initialZoom: 16.0,
                maxZoom: 18,
                minZoom: 6,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  tileBuilder: context.isDarkMode
                      ? (context, tileWidget, tile) {
                          return darkMapFilter(tileWidget);
                        }
                      : null,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: mapHeight,
                  width: context.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.transparent,
                        context.scaffoldColor.withValues(alpha: .1),
                        context.scaffoldColor.withValues(alpha: .3),
                        context.scaffoldColor,
                      ],
                    ),
                  ),
                ),
                Container(
                  width: context.width,
                  color: context.scaffoldColor,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(16),
                      Text(
                        'Monday 22 Feb, 1:23PM',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontSize: 22,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Honda Civic • MHC-8213',
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      const Gap(18),
                      divider,
                      const Gap(18),
                      Text(
                        'Trip Details',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontSize: 22,
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.start,
                        isFirst: true,
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
                              const Gap(30),
                              Text(
                                'FROM',
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red,
                                ),
                              ),
                              const Gap(6),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Atta Mills Road',
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '3:24 PM',
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(6),
                              Text(
                                'Father Patrick Lynch Street, Low Cost Estate, '
                                'Region, BU-0003-8544, Ghana',
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelMedium,
                              ),
                              const Gap(14),
                            ],
                          ),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.start,
                        isLast: true,
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
                              const Gap(30),
                              Text(
                                'To',
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red,
                                ),
                              ),
                              const Gap(6),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Town Park',
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '3:24 PM',
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(6),
                              Text(
                                'Father Patrick Lynch Street, Low Cost Estate, '
                                'Region, BU-0003-8544, Ghana',
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelMedium,
                              ),
                              const Gap(14),
                            ],
                          ),
                        ),
                      ),
                      const Gap(18),
                      divider,
                      const Gap(18),

                      ///
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Abu National',
                                  style: context.textTheme.headlineMedium
                                      ?.copyWith(fontSize: 20),
                                ),
                                const Gap(4),
                                Row(
                                  children: [
                                    Text(
                                      'Your rating',
                                      style: context.textTheme.labelSmall
                                          ?.copyWith(
                                        fontSize: 14,
                                        color: AppColors.red,
                                      ),
                                    ),
                                    const Gap(8),
                                    ...List.generate(
                                      5,
                                      (index) => Icon(
                                        Icons.star,
                                        color: index > 2
                                            ? AppColors.grey1
                                            : AppColors.red,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Gap(18),
                          ImageLoader(
                            height: 60,
                            width: 60,
                            radius: 60,
                            imageUrl: 'https://d1flfk77wl2xk4.cloudfront.'
                                'net/Assets/00/814/l_p0122481400.jpg',
                          ),
                        ],
                      ),

                      ///
                      const Gap(18),
                      divider,
                      const Gap(12),
                      Text(
                        'Fare Breakdown',
                        style: context.textTheme.headlineMedium
                            ?.copyWith(fontSize: 22),
                      ),
                      const Gap(18),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Base Fare',
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          Text(
                            '\$12.50',
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      const Gap(18),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Booking Fare',
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          Text(
                            '\$2.50',
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      const Gap(18),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Promo',
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          Text(
                            '-\$10.5',
                            style: context.textTheme.labelLarge?.copyWith(
                              color: context.colors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Total',
                              style: context.textTheme.labelLarge?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            '-\$10.5',
                            style: context.textTheme.labelLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      divider,
                      const Gap(12),
                      Row(
                        children: [
                          ImageLoader(
                            isAsset: true,
                            imageUrl: 'assets/png/mtn-momo.webp',
                            height: 50,
                            width: 50,
                          ),
                          const Gap(6),
                          Text(
                            'MTN MOMO',
                            style: context.textTheme.headlineSmall,
                          ),
                          const Gap(8),
                          Text(
                            '05** *** *23',
                            style: context.textTheme.headlineMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Gap(80)
              ],
            ),
          ),
          Consumer<UiNotifier>(
            builder: (context, notifier, child) {
              double pos = -310 + notifier.rideDetailScrollPos;
              double opacity = ((notifier.rideDetailScrollPos) / 340) - .3;

              return Positioned(
                top: pos > 0 ? 0 : pos,
                left: 0,
                right: 0,
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: context.scaffoldColor,
                  ),
                  child: Opacity(
                    opacity: opacity > 1 ? 1 : (opacity < 0 ? 0 : opacity),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Monday 22 Feb, 1:23PM',
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Honda Civic • MHC-8213',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const Gap(8),
                        Divider(
                          color: AppColors.grey.withValues(alpha: .2),
                          height: 0,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 52,
            left: 14,
            child: CircularIconBtn(
              onTap: () => context.pop(),
              bgColor: context.colors.surface,
            ),
          ),
        ],
      ),
    );
  }
}
