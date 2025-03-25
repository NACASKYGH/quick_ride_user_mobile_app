import 'package:gap/gap.dart';
import '../../../routes.dart';
import '/utils/app_colors.dart';
import '/utils/extensions.dart';
import '../../../utils/constants.dart';
import '../../widget/base_screen.dart';
import '../../widget/page_loader.dart';
import 'package:flutter/material.dart';
import '../../widget/image_loader.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../notifiers/buses_notifier.dart';
import '../../widget/empty_state_widget.dart';
import '../../widget/error_state_widget.dart';
import '../../../entity/bus_info_entity.dart';
import '/presentation/notifiers/auth_notifier.dart';

class AvailableBusesScreen extends StatefulWidget {
  const AvailableBusesScreen({super.key, required this.to, required this.from});

  final String to;
  final String from;

  @override
  State<AvailableBusesScreen> createState() => _AvailableBusesScreenState();
}

class _AvailableBusesScreenState extends State<AvailableBusesScreen> {
  late BusesNotifier busesNotifier;
  late AuthNotifier authNotifier;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      busesNotifier.getBuses(
        to: widget.to,
        from: widget.from,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    busesNotifier = context.watch<BusesNotifier>();
    authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          'Available Buses',
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: BaseScreen(
        safeArea: SafeArea(
          child: Column(
            children: [
              const Gap(12),
              Expanded(
                child: (busesNotifier.getBusesErrorMsg ?? '').isNotEmpty &&
                        !(busesNotifier.getBusesErrorMsg ?? '').isNotFound
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        child: ErrorStateWidget(
                            title: 'Oops!',
                            desc: busesNotifier.getBusesErrorMsg ??
                                'An error occurred.',
                            onRetry: () {
                              busesNotifier.getBuses(
                                to: widget.to,
                                from: widget.from,
                              );
                            }),
                      )
                    : busesNotifier.isLoading && busesNotifier.busesInfo.isEmpty
                        ? const PageLoader(
                            title: 'Loading available buses...',
                          )
                        : busesNotifier.busesInfo.isEmpty ||
                                (busesNotifier.getBusesErrorMsg ?? '')
                                    .isNotFound
                            ? EmptyStateWidget(
                                title: 'No record Found',
                                desc: 'You do not have any booked ticket.',
                                padding: const EdgeInsets.only(bottom: 120),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 32),
                                itemCount: busesNotifier.busesInfo.length,
                                itemBuilder: (context, index) {
                                  return BusesItem(
                                    busInfoEntity:
                                        busesNotifier.busesInfo[index],
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BusesItem extends StatelessWidget {
  const BusesItem({
    super.key,
    required this.busInfoEntity,
  });

  final BusInfoEntity busInfoEntity;

  @override
  Widget build(BuildContext context) {
    TimeOfDay? departingTime = busInfoEntity.departTime
        ?.replaceFirst('AM', ' AM')
        .replaceAll('PM', ' PM')
        .stringDateToTimeOfDay;

    TimeOfDay? reportingTime = departingTime?.replacing(
      hour: departingTime.hour - 1,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      child: Material(
        color: context.isDarkMode ? AppColors.grey800 : AppColors.lightBg,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            context.pushNamed(
              RouteConsts.busSeat,
              extra: busInfoEntity,
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFF2F2F2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageLoader(
                      imageUrl: busInfoEntity.avatar ?? emptyAssetImage,
                      isAsset: busInfoEntity.avatar == null,
                      width: 80,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    const Gap(6),
                    Expanded(
                      child: Text(
                        '${busInfoEntity.fromLocation} -> ${busInfoEntity.toLocation}',
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${busInfoEntity.terminalName}',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Gap(6),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${busInfoEntity.busType}',
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'Report At\n',
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        reportingTime?.format(context) ?? 'N/A',
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'Depart At\n',
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        departingTime?.format(context) ?? 'N/A',
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),

                    ///
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue.withValues(alpha: .06),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            busInfoEntity.totalSeats ?? '',
                            style: context.textTheme.headlineSmall?.copyWith(
                              fontSize: 16,
                              color: AppColors.lightBlue,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            'Seats\nRemaining',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 8,
                              height: 0,
                              color: AppColors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(4),

                    ///
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'GHS ${busInfoEntity.lorryFare}',
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
