import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../../widget/base_screen.dart';
import '../../widget/page_loader.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quick_ride_user/di.dart';
import '../../../entity/ticket_entity.dart';
import '../../widget/error_state_widget.dart';
import 'package:quick_ride_user/utils/extensions.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:quick_ride_user/presentation/notifiers/trips_notifier.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  late TripsNotifier tripsNotifier;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      tripsNotifier.getTicketBookings();
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
                child: (tripsNotifier.getBookingsErrorMsg ?? '').isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        child: ErrorStateWidget(
                            title: 'Oops!',
                            desc: tripsNotifier.getBookingsErrorMsg ??
                                'An error occurred.',
                            onRetry: () {
                              tripsNotifier.getTicketBookings();
                            }),
                      )
                    : tripsNotifier.isLoading &&
                            tripsNotifier.bookingsList.isEmpty
                        ? const PageLoader(
                            title: 'Loading available buses...',
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 32),
                            itemCount: tripsNotifier.bookingsList.length,
                            itemBuilder: (context, index) {
                              return TicketItem(
                                ticketEntity: tripsNotifier.bookingsList[index],
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

class TicketItem extends StatelessWidget {
  const TicketItem({
    super.key,
    required this.ticketEntity,
  });

  final TicketEntity ticketEntity;

  @override
  Widget build(BuildContext context) {
    TripsNotifier tripsNotifier = context.watch<TripsNotifier>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: context.isDarkMode ? AppColors.grey800 : AppColors.lightBg,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () async {
            final result = await FlutterPlatformAlert.showCustomAlert(
              windowTitle: 'Take Action',
              text: '',
              positiveButtonTitle: 'View Ticket',
              neutralButtonTitle: 'Cancel Ticket',
              negativeButtonTitle: 'Close',
              options: PlatformAlertOptions(
                ios: IosAlertOptions(
                  alertStyle: IosAlertStyle.actionSheet,
                  positiveButtonStyle: IosButtonStyle.normal,
                  neutralButtonStyle: IosButtonStyle.destructive,
                  negativeButtonStyle: IosButtonStyle.cancel,
                ),
              ),
            );

            if (result == CustomButton.neutralButton) {
              //
              final result = await FlutterPlatformAlert.showAlert(
                windowTitle: 'Confirmation Required',
                text: 'Do you really want to cancel this ticket?',
                alertStyle: AlertButtonStyle.yesNo,
              );

              if (!context.mounted) return;

              if (result == AlertButton.yesButton) {
                try {
                  bool resp = await showDialog(
                    context: context,
                    builder: (context) => FutureProgressDialog(
                      tripsNotifier.cancelTicket(
                        ticketNumber: ticketEntity.ticketNo!,
                      ),
                    ),
                  );
                  if (resp) tripsNotifier.getTicketBookings();
                } catch (e) {
                  logger.d(e);
                }
              }

              ///
              ///
              ///
            } else if (result == CustomButton.positiveButton) {
              //
            }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ticketEntity.fromStation} -> ${ticketEntity.toStation}',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontSize: 13,
                  ),
                ),
                const Gap(12),
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                      text: 'Ticket Number:   ',
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                      ),
                      children: [
                        TextSpan(
                          text: ticketEntity.ticketNo,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ]),
                ),
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                      text: 'Name on ticket:  ',
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                      ),
                      children: [
                        TextSpan(
                          text: ticketEntity.travelerName,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ]),
                ),
                const Gap(14),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'Booking Date\n',
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                ),
                                children: [
                                  TextSpan(
                                    text: ticketEntity.entryDate
                                            ?.splitMerge(' ', joiner: '\n') ??
                                        'N/A',
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
                            textAlign: TextAlign.end,
                            text: TextSpan(
                                text: 'Trip Depart Date\n',
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                ),
                                children: [
                                  TextSpan(
                                    text: ticketEntity.tripDate
                                            ?.splitMerge(' ', joiner: '\n') ??
                                        'N/A',
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
                            'Seat\nNumber',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 8,
                              height: 0,
                              color: AppColors.lightBlue,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            ticketEntity.seatNo ?? '',
                            style: context.textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
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
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'GHS\n${ticketEntity.fare}',
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
