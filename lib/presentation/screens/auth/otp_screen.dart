import '/routes.dart';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../notifiers/auth_notifier.dart';
import '/presentation/widget/app_button.dart';
import 'package:easy_localization/easy_localization.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.phoneNumber,
    required this.otpCode,
  });

  final String phoneNumber;
  final String otpCode;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  bool isPhoneError = false;
  late String otpCode = widget.otpCode;

  late AuthNotifier authNotifier;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => authNotifier.errorMsg = null);
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = context.watch<AuthNotifier>();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: context.textTheme.headlineLarge?.copyWith(
        color: isPhoneError ? AppColors.red : null,
        fontSize: 28,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey1, width: 1.5),
        ),
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        authNotifier.errorMsg = null;
        context.pushReplacementNamed(
          RouteConsts.phoneScreen,
          extra: widget.phoneNumber,
        );
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
                    'otp.title'.tr(),
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                      // color: context.colors.primary,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'otp.description'.tr(args: [widget.phoneNumber]),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(32),
                  Pinput(
                    length: 6,
                    validator: (s) {
                      return s == otpCode ? null : 'otp.incorrectOTP'.tr();
                    },
                    separatorBuilder: (index) {
                      return Spacer();
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: false,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border(
                          bottom:
                              BorderSide(color: AppColors.black, width: 1.5)),
                    ),
                    errorTextStyle: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      AppButton(
                        isNegative: true,
                        translateText: true,
                        title: 'otp.resend',
                        width: 150,
                        onTap: () async {
                          String? resp = await authNotifier.checkPhone(
                            phone: widget.phoneNumber,
                          );
                          if (resp == null || !context.mounted) return;
                          if (resp.isEmpty) {
                            //Goto password screen
                            // Do nothing
                          } else {
                            setState(() => otpCode = resp);
                          }
                        },
                        textStyle: context.textTheme.headlineSmall,
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.refresh_rounded,
                            size: 28,
                            color: context.textTheme.headlineSmall?.color,
                          ),
                        ),
                      ),
                      Spacer(),
                      AppButton(
                        title: 'shared.next',
                        translateText: true,
                        width: 100,
                        onTap: () {
                          if (!formKey.currentState!.validate()) return;
                          context.pushReplacementNamed(
                            RouteConsts.signUpName,
                            extra: (widget.phoneNumber, otpCode),
                          );
                        },
                        trailing: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.whiteText,
                          ),
                        ),
                      )
                    ],
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
