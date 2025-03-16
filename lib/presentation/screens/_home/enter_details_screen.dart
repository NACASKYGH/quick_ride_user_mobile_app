import 'package:gap/gap.dart';
import '../../widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'package:quick_ride_user/di.dart';
import '../../widget/app_drop_down.dart';
import '../../widget/app_text_field.dart';
import 'package:collection/collection.dart';
import '../../notifiers/auth_notifier.dart';
import '../../notifiers/buses_notifier.dart';
import '../../../entity/bus_info_entity.dart';
import 'package:quick_ride_user/utils/utilities.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:quick_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:quick_ride_user/presentation/widget/base_screen.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({
    super.key,
    required this.bus,
  });

  final BusInfoEntity bus;

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool useSingleInfo = false;

  late BusesNotifier busesNotifier;
  late AuthNotifier authNotifier;

  // late List<Map<String, dynamic>> bookingInfoList = List.generate(
  //   busesNotifier.selectedSeats.length,
  //   (i) => {
  //     'phone': '',
  //     'name': '',
  //   },
  // );
  late List<TextEditingController> nameControllers = List.generate(
      busesNotifier.selectedSeats.length, (i) => TextEditingController());

  late List<TextEditingController> ageControllers = List.generate(
      busesNotifier.selectedSeats.length, (i) => TextEditingController());

  late List<String> genders = List.generate(busesNotifier.selectedSeats.length,
      (i) => authNotifier.appUser?.gender ?? 'Male');

  final TextEditingController contactController = TextEditingController();
  final TextEditingController kinPhoneController = TextEditingController();
  final TextEditingController kinNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    busesNotifier = context.watch<BusesNotifier>();
    authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.transparent,
        title: Text(
          'Enter Details',
          style: context.textTheme.headlineSmall,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: BaseScreen(
        safeArea: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(12),
                        AppTextField(
                          labelSpace: 2,
                          labelStyle: context.textTheme.labelMedium,
                          label: 'Contact No*',
                          hintText: 'Contact Number',
                          initialValue: authNotifier.appUser?.phone,
                          controller: contactController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Contact number is required!';
                            }
                            if (value.trim() == '0000000000' ||
                                value.trim() == '1111111111') {
                              return null;
                            }

                            if (value.isNotEmpty && value.trim().length < 10) {
                              return 'Invalid phone number!';
                            }
                            return null;
                          },
                        ),

                        ///
                        const Gap(24),

                        Text(
                          'Next of Kin details',
                          style: context.textTheme.headlineSmall,
                        ),
                        const Gap(4),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AppTextField(
                                  labelSpace: 2,
                                  labelStyle: context.textTheme.labelMedium,
                                  label: 'Kin\'s Phone Number',
                                  hintText: 'Phone number',
                                  keyboardType: TextInputType.phone,
                                  controller: kinPhoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Kin\'s contact is required';
                                    }

                                    if (value.trim() == '0000000000' ||
                                        value.trim() == '1111111111') {
                                      return null;
                                    }

                                    if (value.isNotEmpty &&
                                        value.trim().length < 10) {
                                      return 'Invalid phone number!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) async {
                                    if (value.isPhone) {
                                      String? name = await busesNotifier
                                          .getNameFromPhone(phone: value);
                                      kinNameController.text = name ?? '';
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              const Gap(6),
                              Expanded(
                                child: AppTextField(
                                  labelSpace: 2,
                                  labelStyle: context.textTheme.labelMedium,
                                  label: 'Kin\'s Name',
                                  hintText: 'Name',
                                  keyboardType: TextInputType.text,
                                  controller: kinNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Kin\'s name is required!';
                                    }

                                    if (value.length < 2) {
                                      return 'Enter a valid name.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(24),

                        Text(
                          'Traveler details',
                          style: context.textTheme.headlineSmall,
                        ),
                        const Gap(4),
                        for (int i = 0;
                            i < busesNotifier.selectedSeats.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.darkBg
                                            .withValues(alpha: .3),
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Text(
                                    (busesNotifier.selectedSeats[i].position ??
                                            '')
                                        .replaceFirst('E', ''),
                                    textAlign: TextAlign.center,
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      color: AppColors.whiteText,
                                    ),
                                  ),
                                ),
                                const Gap(6),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppTextField(
                                        labelSpace: 2,
                                        labelStyle:
                                            context.textTheme.labelMedium,
                                        label: 'Name*',
                                        hintText: 'Name',
                                        initialValue: nameControllers[i].text,
                                        controller: nameControllers[i],
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Name is required!';
                                          }

                                          if (value.length < 2) {
                                            return 'Enter a valid name.';
                                          }
                                          return null;
                                        },
                                      ),
                                      const Gap(6),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: AppTextField(
                                              labelSpace: 2,
                                              labelStyle:
                                                  context.textTheme.labelMedium,
                                              label: 'Age*',
                                              hintText: 'Age (e.g. 30)',
                                              initialValue:
                                                  ageControllers[i].text,
                                              controller: ageControllers[i],
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Age is required!';
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                          const Gap(6),
                                          Expanded(
                                            child: AppDropDown(
                                              labelSpace: 2,
                                              label: 'Gender*',
                                              labelStyle:
                                                  context.textTheme.labelMedium,
                                              initialValue: authNotifier
                                                      .appUser?.gender ??
                                                  'Male',
                                              borderColor: AppColors.grey
                                                  .withValues(alpha: .7),
                                              hintText:
                                                  'settings.selectGender'.tr(),
                                              dropdownList: [
                                                'settings.male'.tr(),
                                                'settings.female'.tr(),
                                              ],
                                              onChanged: (value) {
                                                if (value == null) return;
                                                setState(
                                                    () => genders[i] = value);
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AppButton(
                  title: 'Proceed',
                  isLoading: isLoading,
                  onTap: () async {
                    if (!formKey.currentState!.validate()) return;
                    setState(() => isLoading = true);
                    if (genders.firstWhereOrNull((gender) => gender.isEmpty) !=
                        null) {
                      toast('Make sure all gender fields are filled');
                      return;
                    }

                    List<Map<String, dynamic>> payloads =
                        busesNotifier.selectedSeats
                            .mapIndexed((index, element) => {
                                  'UserID': '${authNotifier.appUser?.id}',
                                  'BookingLocation': widget.bus.fromLocationId,
                                  'TripID': widget.bus.tripId,
                                  'TravelDate': busesNotifier.chosenDateTime,
                                  'PayMode': 'CASH',
                                  'FromLocation': widget.bus.fromLocationId,
                                  'ToLocation': widget.bus.destinationId,
                                  'Fare': widget.bus.lorryFare,
                                  'MobileNo': genders[index],
                                  'KinName': kinNameController.text,
                                  'KinContact': kinPhoneController.text,
                                  'MomoServiceProvider': '',
                                  'MOMONumber': '',
                                  'PassengerList': [
                                    {
                                      'TName': nameControllers[index].text,
                                      'TGender': 'M',
                                      'TAge': '00',
                                      'TSeatNo': busesNotifier
                                          .selectedSeats[index].seatNumber
                                          ?.replaceFirst('E', ''),
                                      'TIDType': '0',
                                      'TIDNo': '',
                                      'TDOB': busesNotifier.chosenDateTime,
                                      'TCountry': '0'
                                    }
                                  ],
                                })
                            .toList();

                    logger.d(payloads);
                    await appBottomModalSheet(
                      context: context,
                      child: PaymentDetails(),
                    );
                    setState(() => isLoading = false);
                  },
                ),
              ),
              const Gap(6),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///
            ],
          ),
        ),
      ),
    );
  }
}
