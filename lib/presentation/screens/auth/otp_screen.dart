import '../../../di.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'package:x_ride_user/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  bool isPhoneError = false;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
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
                  'otp.description'.tr(args: ['0208457888']),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Gap(32),
                Pinput(
                  length: 4,
                  onCompleted: (pin) => logger.d(pin),
                  validator: (s) {
                    return s == '2222' ? null : 'otp.incorrectOTP'.tr();
                  },
                  separatorBuilder: (index) {
                    return Spacer();
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: false,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border(
                        bottom: BorderSide(color: AppColors.black, width: 1.5)),
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
                      title: 'otp.resend',
                      width: 150,
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;
                      },
                      textStyle: context.textTheme.headlineSmall?.copyWith(
                          //
                          ),
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
                      title: 'otp.login',
                      width: 100,
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;
                        GoRouter.of(context)
                            .popUntil('/${RouteConsts.signUpName}');
                        context.pushReplacementNamed(RouteConsts.signUpName);
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
    );
  }
}
