import '/routes.dart';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import '/presentation/widget/app_button.dart';
import '/presentation/widget/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  bool isPhoneError = false;

  @override
  Widget build(BuildContext context) {
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
                  'phoneNumber.title'.tr(),
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontSize: 28,
                    // color: context.colors.primary,
                  ),
                ),
                const Gap(8),
                Text(
                  'phoneNumber.description'.tr(),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Gap(32),
                AppTextField(
                  hintText: '0200000000',
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
                  errorStyle: isPhoneError
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
                    setState(() => isPhoneError = false);
                    return null;
                  },
                ),

                ///
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    AppButton(
                      isDisabled: phoneController.text.isEmpty,
                      title: 'shared.next',
                      width: 100,
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;
                        context.pushNamed(RouteConsts.otpScreen);
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
