import 'package:gap/gap.dart';
import 'payment_details.dart';
import '/utils/utilities.dart';
import '/utils/extensions.dart';
import '../../widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../widget/app_drop_down.dart';
import '../../widget/app_text_field.dart';
import 'package:collection/collection.dart';
import '../../notifiers/auth_notifier.dart';
import '../../notifiers/buses_notifier.dart';
import '../../../entity/bus_info_entity.dart';
import '/presentation/widget/base_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:easy_localization/easy_localization.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({super.key, required this.bus});

  final BusInfoEntity bus;

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  late List<TextEditingController> ageControllers = List.generate(
    busesNotifier.selectedSeats.length,
    (i) => TextEditingController(),
  );

  late AuthNotifier authNotifier;
  late BusesNotifier busesNotifier;
  final TextEditingController contactController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late List<String> genders = List.generate(
    busesNotifier.selectedSeats.length,
    (i) => authNotifier.appUser?.gender ?? 'Male',
  );

  bool isLoading = false;
  final TextEditingController kinNameController = TextEditingController();
  final TextEditingController kinPhoneController = TextEditingController();
  late List<TextEditingController> nameControllers = List.generate(
    busesNotifier.selectedSeats.length,
    (i) => TextEditingController(),
  );

  bool useSingleInfo = false;

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
                                  initialValue: authNotifier.appUser?.kinNumber,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Kin\'s contact is required';
                                    }

                                    if (value.trim() == '0000000000' ||
                                        value.trim() == '1111111111') {
                                      return null;
                                    }

                                    if (value.isNotEmpty &&
                                        value.trim().length < 10 &&
                                        value !=
                                            authNotifier.appUser?.kinNumber) {
                                      return 'Invalid phone number!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) async {
                                    if (value.isPhone &&
                                        value !=
                                            authNotifier.appUser?.kinNumber) {
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
                                  initialValue: authNotifier.appUser?.kinName,
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
                        for (
                          int index = 0;
                          index < busesNotifier.selectedSeats.length;
                          index++
                        )
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
                                        color: AppColors.darkBg.withValues(
                                          alpha: .3,
                                        ),
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    (busesNotifier
                                                .selectedSeats[index]
                                                .position ??
                                            '')
                                        .replaceFirst('E', ''),
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(color: AppColors.whiteText),
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
                                        initialValue:
                                            index == 0
                                                ? authNotifier.appUser?.name
                                                : nameControllers[index].text,
                                        controller: nameControllers[index],
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
                                                  index == 0
                                                      ? authNotifier
                                                              .appUser
                                                              ?.age ??
                                                          authNotifier
                                                              .appUser
                                                              ?.dateOfBirth
                                                              ?.toDateTime2
                                                              ?.getAge
                                                              .years
                                                              .toString()
                                                      : ageControllers[index]
                                                          .text,
                                              controller: ageControllers[index],
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
                                              initialValue:
                                                  index == 0
                                                      ? authNotifier
                                                          .appUser
                                                          ?.gender
                                                      : 'Male',
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
                                                  () => genders[index] = value,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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

                    Map<String, dynamic> payload = {
                      'ChanelType': 'MOB',
                      'BookbyType': 'U',
                      'UserID': '${authNotifier.appUser?.id}',
                      'BookingLocation': widget.bus.fromLocationId,
                      'TripID': widget.bus.tripId,
                      'TravelDate': busesNotifier.chosenDateTime,
                      'FromLocation': widget.bus.fromLocationId,
                      'ToLocation': widget.bus.destinationId,
                      'KinName': kinNameController.text,
                      'KinContact': kinPhoneController.text,
                      'MomoServiceProvider': '',
                      'MOMONumber': '',
                      'EmailID': '',
                      'FreeBillIDNo': '',
                      'PayMode': 'ONLINE',
                      'CurrencyID': '4',
                      'Fare': (busesNotifier.selectedSeats.length *
                              num.parse(widget.bus.lorryFare ?? '0'))
                          .toStringAsFixed(2),
                      'MobileNo': contactController.text,
                      'PassengerList': [
                        ...busesNotifier.selectedSeats.mapIndexed(
                          (index, seat) => {
                            'TName': nameControllers[index].text,
                            'TGender': genders[index].toUpperCase(),
                            'TAge': ageControllers[index].text,
                            'TSeatNo': busesNotifier
                                .selectedSeats[index]
                                .seatNumber
                                ?.replaceFirst('E', ''),
                            'TIDType': authNotifier.appUser?.idType ?? '0',
                            'TIDNo': authNotifier.appUser?.idNumber ?? '',
                            'TDOB':
                                DateTime.now()
                                    .subtract(
                                      Duration(
                                        days:
                                            365 *
                                            (int.tryParse(
                                                  ageControllers[index].text,
                                                ) ??
                                                0),
                                      ),
                                    )
                                    .toString(),
                            'TCountry': '0',
                          },
                        ),
                      ],
                    };

                    await appBottomModalSheet(
                      context: context,
                      isDismissible: false,
                      expand: true,
                      child: PaymentDetails(bus: widget.bus, payload: payload),
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
