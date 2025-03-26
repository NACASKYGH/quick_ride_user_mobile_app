import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../../widget/base_screen.dart';
import '../../widget/page_loader.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../widget/empty_state_widget.dart';
import '../../widget/error_state_widget.dart';
import '../../../entity/cancelled_ticket_entity.dart';
import 'package:quick_ride_user/utils/extensions.dart';
import 'package:quick_ride_user/presentation/notifiers/trips_notifier.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  late TripsNotifier tripsNotifier;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      tripsNotifier.getCancelTicket();
    });
  }

  @override
  Widget build(BuildContext context) {
    tripsNotifier = context.watch<TripsNotifier>();

    return Scaffold(
      body: BaseScreen(
        safeArea: SafeArea(
          child: Column(
            children: [
              const Gap(12),
              Expanded(
                child: (tripsNotifier.getCancelsErrorMsg ?? '').isNotEmpty &&
                        !(tripsNotifier.getCancelsErrorMsg ?? '').isNotFound
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        child: ErrorStateWidget(
                            title: 'Oops!',
                            desc: tripsNotifier.getCancelsErrorMsg ??
                                'An error occurred.',
                            onRetry: () {
                              tripsNotifier.getCancelTicket();
                            }),
                      )
                    : tripsNotifier.isCancelLoading &&
                            tripsNotifier.cancelledList.isEmpty
                        ? const PageLoader(
                            title: 'Loading available buses...',
                          )
                        : tripsNotifier.cancelledList.isEmpty ||
                                (tripsNotifier.getCancelsErrorMsg ?? '')
                                    .isNotFound
                            ? EmptyStateWidget(
                                title: 'No record Found',
                                desc: 'You do not have any cancelled ticket.',
                                padding: const EdgeInsets.only(bottom: 120),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 32),
                                itemCount: tripsNotifier.cancelledList.length,
                                itemBuilder: (context, index) {
                                  return CancelledTicketItem(
                                    ticketEntity:
                                        tripsNotifier.cancelledList[index],
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

class CancelledTicketItem extends StatelessWidget {
  const CancelledTicketItem({
    super.key,
    required this.ticketEntity,
  });

  final CancelledTicketEntity ticketEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: context.isDarkMode ? AppColors.grey800 : AppColors.lightBg,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: 'Can. Name\n',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 9,
                            ),
                            children: [
                              TextSpan(
                                text: ticketEntity.canName,
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Cancel Date\n',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                          ),
                          children: [
                            TextSpan(
                              text: ticketEntity
                                  .cancelDate?.toDateTime3?.dayMonthDayFYear,
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: 'Ticket ID:\n',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 9,
                            ),
                            children: [
                              TextSpan(
                                text: ticketEntity.ticketNo,
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Cancellation Code:\n',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                          ),
                          children: [
                            TextSpan(
                              text: ticketEntity.cancelCode,
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: 'Payment Status:\n',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 9,
                            ),
                            children: [
                              TextSpan(
                                text: ticketEntity.paymentStatus,
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  fontSize: 13,
                                  color: ticketEntity.paymentStatus
                                              ?.toLowerCase() ==
                                          'pending'
                                      ? AppColors.yellow
                                      : AppColors.lightBlue,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          'Ticket\nAmount',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 8,
                            height: 0,
                            color: AppColors.lightBlue,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          ticketEntity.ticketAmt ?? '',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 18,
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(4),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.red.withValues(alpha: .06),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel\nFee',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 8,
                            height: 0,
                            color: AppColors.red,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          ticketEntity.cancelAmt ?? '',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 18,
                            color: AppColors.red,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Refund\nAmount',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 8,
                            height: 0,
                            color: AppColors.white,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          ticketEntity.refundAmt ?? '',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
