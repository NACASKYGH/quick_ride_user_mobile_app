import '../../../routes.dart';
import 'package:gap/gap.dart';
import '/utils/app_colors.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../notifiers/trips_notifier.dart';
import '/presentation/widget/app_button.dart';
import '/presentation/widget/base_screen.dart';
import '/presentation/widget/image_loader.dart';
import '/presentation/widget/app_text_field.dart';
import '/presentation/notifiers/auth_notifier.dart';
import '/presentation/notifiers/buses_notifier.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  DateTime travelingDate = DateTime.now();

  late TripsNotifier tripsNotifier;
  late BusesNotifier busesNotifier;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      busesNotifier.getLocations();
      tripsNotifier.getTicketBookings(clear: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    tripsNotifier = context.watch<TripsNotifier>();
    AuthNotifier authNotifier = context.watch<AuthNotifier>();
    busesNotifier = context.watch<BusesNotifier>();

    return BaseScreen(
      safeArea: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                if (authNotifier.appUser == null)
                  Row(
                    children: [
                      const Spacer(),
                      AppButton(
                        width: 120,
                        title: 'Login',
                        isNegative: true,
                        onTap: () => context.pushNamed(RouteConsts.phoneScreen),
                      ),
                    ],
                  ),
                if (authNotifier.appUser != null) ...[
                  RichText(
                    text: TextSpan(
                      text:
                          'Hi ${authNotifier.appUser?.name?.splitReturnMerge(' ', [0])},\n',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: 24,
                      ),
                      children: [
                        TextSpan(
                          text: 'Where  would you like to go?',
                          style: context.textTheme.labelMedium?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ],

                ///
                ///
                ///
                ///
                ///
                const Gap(30),

                AppTextField(
                  label: 'Where From',
                  hintText: 'Traveling from?',
                  controller: fromController,
                  prefixWidget: Icon(Icons.trending_up_rounded),
                  validator: (p0) {
                    if ((p0 ?? '').length < 2) {
                      return 'Enter at least 3 characters';
                    }
                    return null;
                  },
                ),
                const Gap(14),
                AppTextField(
                  label: 'Where To?',
                  hintText: 'Traveling to?',
                  controller: toController,
                  prefixWidget: Icon(Icons.trending_down_rounded),
                  validator: (p0) {
                    if ((p0 ?? '').length < 2) {
                      return 'Enter at least 3 characters';
                    }
                    return null;
                  },
                ),
                const Gap(14),
                GestureDetector(
                  onTap: () async {
                    final date = await showDatePickerDialog(
                      context: context,
                      initialDate: travelingDate,
                      minDate: DateTime.now(),
                      maxDate: DateTime.now().add(const Duration(days: 31)),
                      selectedDate: travelingDate,
                      initialPickerType: PickerType.days,
                      leadingDateTextStyle: context.textTheme.headlineSmall,
                      centerLeadingDate: true,
                      enabledCellsTextStyle: context.textTheme.labelMedium,
                      currentDateTextStyle: context.textTheme.labelMedium,
                      selectedCellTextStyle: context.textTheme.labelMedium,
                      disabledCellsTextStyle: context.textTheme.labelMedium
                          ?.copyWith(
                            color: AppColors.grey1.withValues(alpha: .8),
                          ),
                    );

                    if (date != null) {
                      dateController.text = date.dateFormat1;
                      busesNotifier.chosenDateTime = date.dateFormat1;
                      setState(() => travelingDate = date);
                    }
                  },
                  child: AppTextField(
                    label: 'Traveling Date',
                    hintText: 'Traveling Date?',
                    controller: dateController,
                    initialValue: travelingDate.dateFormat1,
                    disabled: true,
                    prefixWidget: Icon(Icons.date_range_rounded),
                    validator: (p0) {
                      if (p0?.toDateTime != null) {
                        return 'Choose a date';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(24),

                AppButton(
                  title: 'Search',
                  isGradient: true,
                  radius: 8,
                  onTap: () {
                    if (!formKey.currentState!.validate()) return;
                    context.pushNamed(
                      RouteConsts.availableBuses,
                      extra: (
                        fromController.text,
                        toController.text,
                        travelingDate.ddMMMy,
                      ),
                    );
                  },
                ),

                ////
                ///
                ///
                ///
                ///
                const Spacer(),
                const Spacer(),

                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/png/pattern-with-gradient1.png',
                        color: AppColors.lightBlue.withValues(alpha: .2),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 150,
                                viewportFraction: 0.8,
                                autoPlay: true,
                                enlargeCenterPage: true,
                              ),
                              items:
                                  ['NRSA', '0', '2', '6', '4'].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return ImageLoader(
                                          imageUrl: 'assets/png/$i.png',
                                          isAsset: true,
                                          fit: BoxFit.contain,
                                        );
                                      },
                                    );
                                  }).toList(),
                            ),
                          ),
                          const Gap(12),
                          SizedBox(
                            width: 120,
                            child: Text(
                              'Our Trusted Partners',
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineLarge?.copyWith(
                                fontSize: 24,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
