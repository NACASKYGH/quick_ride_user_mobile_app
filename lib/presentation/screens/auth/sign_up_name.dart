import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'package:x_ride_user/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';
import 'package:x_ride_user/presentation/widget/app_text_field.dart';

class SignUpName extends StatefulWidget {
  const SignUpName({super.key});

  @override
  State<SignUpName> createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
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
                  'signUpName.title'.tr(),
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontSize: 28,
                    // color: context.colors.primary,
                  ),
                ),
                const Gap(8),
                Text(
                  'signUpName.description'.tr(),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Gap(32),
                AppTextField(
                  hintText: 'e.g. John Doe',
                  controller: phoneController,
                  keyboardType: TextInputType.text,
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
                  validator: (value) {
                    setState(() => isPhoneError = true);

                    if (value == null || value.isEmpty) {
                      return 'signUpName.requiredName'.tr();
                    }
                    if (value.length < 2) {
                      return 'signUpName.invalidName'.tr();
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
                      title: 'signUpName.signup',
                      width: 100,
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;
                        context.pushReplacementNamed(RouteConsts.index);
                        // context.pushReplacementNamed(RouteConsts.splash);
                      },
                      trailing: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
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
