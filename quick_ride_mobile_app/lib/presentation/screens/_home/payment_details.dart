import '/di.dart';
import 'package:gap/gap.dart';
import '/utils/utilities.dart';
import '/utils/extensions.dart';
import '../shared/app_webview.dart';
import '../../widget/app_button.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../notifiers/auth_notifier.dart';
import '../../../repository/repository.dart';
import '../../notifiers/buses_notifier.dart';
import '../../notifiers/trips_notifier.dart';
import '../../../entity/bus_info_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key, required this.bus, required this.payload});

  final BusInfoEntity bus;
  final Map<String, dynamic> payload;

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final _scrollController = ScrollController();

  bool isChecked = false;

  double onlineCharges(String? price) {
    double singleSeatFare = double.tryParse(price ?? '0.0') ?? 0.0;
    if (singleSeatFare <= 300) {
      return 4.00;
    } else if (singleSeatFare > 300 && singleSeatFare <= 500) {
      return 7.00;
    } else {
      return 10.00;
    }
  }

  @override
  Widget build(BuildContext context) {
    final busesNotifier = context.watch<BusesNotifier>();
    final tripsNotifier = context.watch<TripsNotifier>();
    final authNotifier = context.watch<AuthNotifier>();

    TimeOfDay? departingTime =
        widget.bus.departTime
            ?.replaceFirst('AM', ' AM')
            .replaceAll('PM', ' PM')
            .stringDateToTimeOfDay;

    TimeOfDay? reportingTime = departingTime?.replacing(
      hour: departingTime.hour - 1,
    );

    double charges =
        onlineCharges(busesNotifier.selectedSeats.first.price) *
        busesNotifier.selectedSeats.length;
    num totalSeatsCost =
        busesNotifier.selectedSeats.length *
        num.parse(widget.bus.lorryFare ?? '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Review', style: context.textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 7,
          radius: Radius.circular(15),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Gap(8),
                Column(
                  children: [
                    ...[
                      ('Travel Date:', busesNotifier.chosenDateTime),
                      ('Report Time:', reportingTime?.format(context)),
                      ('Start Time:', departingTime?.format(context)),
                      ('From:', widget.bus.fromLocation),
                      ('To:', widget.bus.toLocation),
                      (
                        'Seat number(s):',
                        busesNotifier.selectedSeats
                            .map((e) => e.seatNumber?.replaceFirst('E', ''))
                            .join(', '),
                      ),
                    ].map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.$1,
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const Gap(80),
                            Expanded(
                              child: Text(
                                item.$2 ?? '',
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(25),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.colors.tertiary,
                  ),
                  child: Text(
                    'Summary',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const Gap(15),

                ////
                ///
                ///
                ///
                ///
                ///
                Padding(
                  padding: EdgeInsets.only(left: 45, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Details',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        'Amount GHC',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.tertiary,
                            border: Border(
                              right: BorderSide(color: AppColors.white),
                            ),
                          ),
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: context.textTheme.labelMedium?.copyWith(
                                fontSize: 12,
                              ),
                              children: [
                                const TextSpan(text: 'Ticket booking from\n'),
                                TextSpan(
                                  text: widget.bus.fromLocation,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(text: 'to'),
                                TextSpan(
                                  text: widget.bus.toLocation,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.tertiary,
                            border: Border(
                              left: BorderSide(color: AppColors.white),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'GHS $totalSeatsCost',
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          border: Border.all(color: context.colors.tertiary),
                        ),
                        child: Text(
                          'Seat number(s)',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    //SizedBox(width: 1.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          border: Border.all(color: context.colors.tertiary),
                        ),
                        child: Text(
                          busesNotifier.selectedSeats
                              .map((e) => e.seatNumber?.replaceFirst('E', ''))
                              .join(', '),
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.tertiary,
                            border: Border(
                              right: BorderSide(color: AppColors.white),
                            ),
                          ),
                          child: Text(
                            'Online Charges',
                            style: context.textTheme.labelMedium?.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.tertiary,
                            border: Border(
                              left: BorderSide(color: AppColors.white),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'GHS $charges',
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Total Amount',
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'GHS ${(totalSeatsCost + charges).toStringAsFixed(2)}',
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///
                ///
                ///
                ///
                ///
                ///
                ///
                const Gap(32),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        value: isChecked,
                        onChanged: (v) => setState(() => isChecked = v!),
                      ),
                      const Gap(8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: context.textTheme.headlineSmall?.copyWith(
                              fontSize: 10.5,
                            ),
                            children: [
                              const TextSpan(text: 'I have read and accept'),
                              WidgetSpan(
                                child: InkWell(
                                  onTap:
                                      () => launchUrlString(termsAndConditions),
                                  child: Text(
                                    'Quick RideGH Terms and Conditions',
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: AppColors.primary,
                                          fontSize: 10.5,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(15),
                AppButton(
                  title: 'Book Now',
                  isDisabled: !isChecked,
                  onTap: () async {
                    try {
                      final resp = await showDialog(
                        context: context,
                        builder: (context) {
                          return FutureProgressDialog(
                            getIt<Repository>().bookBusTicket(
                              map: widget.payload,
                            ),
                          );
                        },
                      );
                      if (resp.success && (resp.url ?? '').isNotEmpty) {
                        if (!context.mounted) return;
                        authNotifier.getUserAutoFills();
                        bool? isRedirected = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AppWebview(
                                  title: 'Make Payment',
                                  url: resp.url ?? '',
                                  onPop: () => context.pop(false),
                                  onUrlChanged: (ctx, url) async {
                                    if (url.contains(
                                      'MobilePaymentResponse.aspx',
                                    )) {
                                      await Future.delayed(
                                        const Duration(seconds: 1),
                                      );
                                      if (ctx.mounted) ctx.pop(true);
                                    }
                                    return NavigationDecision.navigate;
                                  },
                                ),
                          ),
                        );

                        if (isRedirected ?? false) {
                          tripsNotifier.getTicketBookings(clear: true);
                          tripsNotifier.getCancelTicket(clear: true);
                          if (!context.mounted) return;
                          GoRouter.of(context).popUntil('/index');
                        }
                      } else {
                        showError(msg: resp.message ?? 'An error occurred');
                      }
                    } catch (e) {
                      showError(msg: e.toString());
                    }
                  },
                ),
                const Gap(17),

                ///
                ///
                ///
                ///
                ///
                ///
                ///
                Text('Note', style: context.textTheme.headlineMedium),
                const Gap(17),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. ',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 10.5,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 10.5,
                          ),
                          children: [
                            const TextSpan(text: 'Kindly read and accept our '),
                            WidgetSpan(
                              child: InkWell(
                                onTap:
                                    () => launchUrlString(termsAndConditions),
                                child: Text(
                                  'terms and conditions',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        fontSize: 10.5,
                                        color: AppColors.primary,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2. ',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 10.5,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 10.5,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  'Complete all payments processes '
                                  'within four minute after clicking on the ',
                            ),
                            TextSpan(
                              text: 'book now button.',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3. ',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 10.5,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Quick RideGH will not guarantee tickets '
                        'confirmation unless payment is implemented.',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '4. ',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 10.5,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 10.5,
                          ),
                          children: const [
                            TextSpan(text: 'Quick RideGH will not accept '),
                            TextSpan(
                              text: 'Pay later ',
                              style: TextStyle(color: AppColors.primary),
                            ),
                            TextSpan(
                              text: 'option, provided on payment gateway.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
