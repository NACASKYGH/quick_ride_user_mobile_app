import '/di.dart';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import '../../../../routes.dart';
import '../shared/app_webview.dart';
import '../../widget/app_button.dart';
import '../../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/app_drop_down.dart';
import '../../widget/app_text_field.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/app_colors.dart';
import '/presentation/widget/base_screen.dart';
import 'package:random_avatar/random_avatar.dart';
import '/presentation/notifiers/ui_notifier.dart';
import '/presentation/notifiers/auth_notifier.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? dateOfBirth;

  String? gender;
  final _fNameController = TextEditingController();
  final _emailController = TextEditingController();
  final dateController = TextEditingController();
  late AuthNotifier authNotifier;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    authNotifier = context.watch<AuthNotifier>();

    if (dateOfBirth == null) {
      try {
        dateOfBirth =
            authNotifier.appUser?.dateOfBirth?.trim().toDateTime2 ??
            DateTime.now();
      } catch (e) {
        logger.e(e);
      }
    }

    return Scaffold(
      body: BaseScreen(
        safeArea: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(16),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SizedBox(
                        width: 96,
                        child: RandomAvatar(
                          authNotifier.appUser?.id ?? 'saytoonz',
                          height: 96,
                          width: 96,
                        ),
                      ),
                      Material(
                        color: AppColors.whiteText,
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          onTap: () async {},
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: context.colors.primary,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),
                  AppTextField(
                    hintText: 'Your name in full',
                    initialValue: authNotifier.appUser?.name,
                    controller: _fNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'settings.fieldIsRequired'.tr();
                      }
                      if (value.length < 2) {
                        return 'Name is too short!';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  AppTextField(
                    hintText: 'Tell us your email',
                    initialValue: authNotifier.appUser?.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required.';
                      }
                      if (!value.isEmail) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: AppDropDown(
                          initialValue: authNotifier.appUser?.gender ?? 'Male',
                          borderColor: AppColors.grey.withValues(alpha: .7),
                          hintText: 'settings.selectGender'.tr(),
                          dropdownList: [
                            'settings.male'.tr(),
                            'settings.female'.tr(),
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final date = await showDatePickerDialog(
                              context: context,
                              initialDate: dateOfBirth,
                              minDate: DateTime.parse('1900-01-01'),
                              maxDate: DateTime.now().add(
                                const Duration(days: 31),
                              ),
                              selectedDate: dateOfBirth,
                              initialPickerType: PickerType.days,
                              leadingDateTextStyle:
                                  context.textTheme.headlineSmall,
                              centerLeadingDate: true,
                              enabledCellsTextStyle:
                                  context.textTheme.labelMedium,
                              currentDateTextStyle:
                                  context.textTheme.labelMedium,
                              selectedCellTextStyle:
                                  context.textTheme.labelMedium,
                              disabledCellsTextStyle: context
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.grey1.withValues(
                                      alpha: .8,
                                    ),
                                  ),
                            );

                            if (date != null) {
                              dateController.text = date.dateFormat1;
                              setState(() => dateOfBirth = date);
                            }
                          },
                          child: AppTextField(
                            hintText: 'Date of Birth',
                            controller: dateController,
                            initialValue: dateOfBirth?.dateFormat1,
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
                      ),
                    ],
                  ),
                  const Gap(14),
                  Row(
                    children: [
                      Spacer(),
                      AppButton(
                        title: 'Update',
                        isLoading: isLoading,
                        isGradient: true,
                        width: 100,
                        height: 36,
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) return;
                          if (gender == null) {
                            toast('Gender is required.');
                            return;
                          }
                          if (dateOfBirth == null) {
                            toast('Date of birth is required');
                            return;
                          }
                          setState(() => isLoading = true);

                          try {
                            await authNotifier.updateUser(
                              name: _fNameController.text,
                              email: _emailController.text,
                              gender: gender!,
                              date: dateOfBirth!.phpStandardTime,
                            );
                          } catch (e) {
                            logger.e(e);
                            toast(e.toString());
                          }
                          setState(() => isLoading = false);
                        },
                      ),
                    ],
                  ),
                  const Gap(42),

                  ///
                  Container(
                    decoration: BoxDecoration(
                      color:
                          context.isDarkMode
                              ? context.colors.tertiary
                              : AppColors.grey100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SettingsListItem(
                          title: 'settings.aboutUs'.tr(),
                          icon: Icons.info_outline_rounded,
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => AppWebview(
                                        title: 'About QuickRide Ghana',
                                        url:
                                            'https://quickridegh.com/Aboutus.aspx',
                                      ),
                                ),
                              ),
                        ),
                        Divider(height: 1, color: context.colors.tertiary),
                        SettingsListItem(
                          title: 'settings.rateUs'.tr(),
                          icon: Icons.star_border_purple500_rounded,
                          onTap: () {
                            launchUrlString(playstoreLink);
                          },
                        ),
                      ],
                    ),
                  ),

                  const Gap(28),

                  ///
                  Container(
                    decoration: BoxDecoration(
                      color:
                          context.isDarkMode
                              ? context.colors.tertiary
                              : AppColors.grey100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SettingsListItem(
                          title: 'settings.changePass'.tr(),
                          icon: Icons.info_outline_rounded,
                          onTap:
                              () =>
                                  context.pushNamed(RouteConsts.changePassword),
                        ),
                        Divider(height: 1, color: context.colors.tertiary),
                        SettingsListItem(
                          title: 'settings.logout'.tr(),
                          icon: Icons.logout_rounded,
                          onTap: () async {
                            final result =
                                await FlutterPlatformAlert.showCustomAlert(
                                  windowTitle: 'Attention!',
                                  text:
                                      'Do you really want to sign out from this device?',
                                  positiveButtonTitle: 'Yes',
                                  negativeButtonTitle: 'Cancel',
                                );
                            if (result == CustomButton.positiveButton &&
                                context.mounted) {
                              authNotifier.signOut();
                              context.read<UiNotifier>().indexTabIndex = 0;
                              context.goNamed(RouteConsts.splash);
                            }
                          },
                        ),
                        Divider(height: 1, color: context.colors.tertiary),
                        SettingsListItem(
                          title: 'settings.deleteAccount'.tr(),
                          icon: Icons.delete_outline_rounded,
                          onTap: () async {
                            final result =
                                await FlutterPlatformAlert.showCustomAlert(
                                  windowTitle: 'Attention!',
                                  text:
                                      'Is this what you want to do?\nDeleting your account?',
                                  positiveButtonTitle: 'Yes',
                                  negativeButtonTitle: 'No',
                                );
                            if (result == CustomButton.positiveButton &&
                                context.mounted) {
                              authNotifier.signOut();
                              context.read<UiNotifier>().indexTabIndex = 0;
                              context.goNamed(RouteConsts.splash);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const Gap(42),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:
          context.isDarkMode ? null : AppColors.grey50.withValues(alpha: .2),
      title: Text(title),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: context.textTheme.labelSmall?.color?.withValues(alpha: .4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: context.colors.surface),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: context.textTheme.labelSmall?.color?.withValues(alpha: .4),
      ),
      onTap: onTap,
    );
  }
}
