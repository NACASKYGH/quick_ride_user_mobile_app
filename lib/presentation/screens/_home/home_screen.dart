import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:quick_ride_user/di.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/widget/app_text_field.dart';
import 'package:quick_ride_user/utils/app_colors.dart';
import 'package:quick_ride_user/utils/extensions.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:quick_ride_user/presentation/widget/app_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime travelingDate = DateTime.now();

  final fromController = TextEditingController();
  final toController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/background-overlay.svg',
          width: context.width,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(70),
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
                        disabledCellsTextStyle:
                            context.textTheme.labelMedium?.copyWith(
                          color: AppColors.grey1.withValues(alpha: .8),
                        ),
                      );

                      if (date != null) {
                        dateController.text = date.dateFormat1;
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
                  Row(
                    children: [
                      Spacer(),
                      AppButton(
                        width: 130,
                        title: 'Search',
                        isGradient: true,
                        onTap: () {
                          if (!formKey.currentState!.validate()) return;
                          final map = {
                            'SourceName': fromController.text,
                            'DestinationName': toController.text,
                            'TravelDate': travelingDate.ddMMMy,
                          };
                          logger.d(map);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
