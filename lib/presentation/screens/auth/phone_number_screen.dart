import '/routes.dart';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import '/presentation/widget/app_button.dart';
import '/presentation/widget/app_text_field.dart';
import '/presentation/notifiers/auth_notifier.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:easy_localization/easy_localization.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPhoneError = false;
  bool showPassword = false;
  bool isSendingOTP = false;

  late AuthNotifier authNotifier;
  String? checkPhoneResp;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => authNotifier.errorMsg = null,
    );
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = context.watch<AuthNotifier>();

    return PopScope(
      canPop: !showPassword,
      onPopInvokedWithResult: (didPop, result) {
        authNotifier.errorMsg = null;
        if (showPassword) setState(() => showPassword = false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(14),
                  Text(
                    showPassword ? 'Login' : 'phoneNumber.title'.tr(),
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    showPassword
                        ? 'Great! You have an account, kindly enter your password to proceed.'
                        : 'phoneNumber.description'.tr(),
                    style: context.textTheme.labelSmall?.copyWith(fontSize: 14),
                  ),
                  const Gap(32),
                  AppTextField(
                    hintText: '0200000000',
                    initialValue: widget.phoneNumber,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    borderColor: AppColors.transparent,
                    onChanged: (_) => setState(() => isPhoneError = false),
                    hintStyle: context.textTheme.headlineMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey1,
                    ),
                    textStyle: context.textTheme.headlineLarge?.copyWith(
                      color: isPhoneError ? AppColors.red : null,
                      fontSize: 28,
                    ),
                    errorStyle:
                        isPhoneError
                            ? null
                            : TextStyle(color: AppColors.transparent),
                    prefixWidget: Text(
                      '  🇬🇭  |  ',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: AppColors.grey.withValues(alpha: .8),
                        height: 2,
                      ),
                    ),
                    validator: (value) {
                      setState(() => isPhoneError = true);

                      if (value == null || value.isEmpty) {
                        return 'phoneNumber.requiredPhone'.tr();
                      }
                      if (value.length < 10) {
                        return 'phoneNumber.invalidPhone'.tr();
                      }

                      if (!value.substring(1).isValidPhone) {
                        return 'phoneNumber.invalidPhone'.tr();
                      }
                      if ((authNotifier.errorMsg ?? '').isNotEmpty &&
                          !showPassword) {
                        return authNotifier.errorMsg;
                      }
                      setState(() => isPhoneError = false);
                      return null;
                    },
                  ),

                  if (showPassword) ...[
                    const Gap(32),
                    AppTextField(
                      hintText: '******',
                      label: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      borderColor: AppColors.grey,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required.';
                        }
                        if (value.length < 6) {
                          return 'Password should be 6 or more characters.';
                        }
                        return null;
                      },
                    ),
                    const Gap(32),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: 'Forgot Password',
                            isNegative: true,
                            onTap: () {},
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: AppButton(
                            title: 'Use OTP',
                            bgColor: AppColors.primary.withValues(alpha: .6),
                            isLoading: isSendingOTP,
                            onTap: () async {
                              setState(() => isSendingOTP = true);
                              try {
                                String? resp = await authNotifier.sendOTP(
                                  phone: phoneController.text,
                                );
                                setState(() => isSendingOTP = false);

                                if (resp == null || !context.mounted) return;
                                context.pushReplacementNamed(
                                  RouteConsts.otpScreen,
                                  extra: (phoneController.text, resp),
                                );
                              } catch (e) {
                                setState(() => isSendingOTP = false);
                                toast(e.toString());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],

                  ///
                  Spacer(),
                  if ((authNotifier.errorMsg ?? '').isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red, width: .5),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        authNotifier.errorMsg ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.red,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  AppButton(
                    isDisabled:
                        isSendingOTP ||
                        phoneController.text.isEmpty ||
                        isPhoneError,
                    translateText: true,
                    title: 'shared.next',
                    isLoading: authNotifier.isLoading,
                    isGradient: true,
                    // width: 100,
                    onTap: () async {
                      if (!formKey.currentState!.validate()) return;
                      if (showPassword) {
                        bool? resp = await authNotifier.login(
                          phone: phoneController.text,
                          password: passwordController.text,
                        );
                        if (resp == true && context.mounted) {
                          showPassword = false;
                          context.pop();
                        }
                        return;
                      }
                      String? resp = await authNotifier.checkPhone(
                        phone: phoneController.text,
                      );
                      if (resp == null || !context.mounted) return;
                      if (resp.isEmpty) {
                        checkPhoneResp = resp;
                        setState(() => showPassword = true);
                      } else {
                        context.pushReplacementNamed(
                          RouteConsts.otpScreen,
                          extra: (phoneController.text, resp),
                        );
                      }
                    },
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteText,
                      ),
                    ),
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
