import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../notifiers/auth_notifier.dart';
import '/presentation/widget/app_button.dart';
import '/presentation/widget/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpName extends StatefulWidget {
  const SignUpName({
    super.key,
    required this.phoneNumber,
    required this.otpCode,
  });

  final String phoneNumber;
  final String otpCode;

  @override
  State<SignUpName> createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  bool isNameError = false;
  bool showPassword = false;

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
                  const Gap(12),
                  Text(
                    'signUpName.title'.tr(),
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  const Gap(6),
                  Text(
                    'Add your name and create a password to secure your account',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(24),
                  AppTextField(
                    hintText: 'e.g. John Doe',
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    borderColor: AppColors.transparent,
                    onChanged: (_) => setState(() => isNameError = false),
                    hintStyle: context.textTheme.headlineMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey1,
                    ),
                    textStyle: context.textTheme.headlineLarge?.copyWith(
                      color: isNameError ? AppColors.red : null,
                      fontSize: 28,
                    ),
                    errorStyle: isNameError
                        ? null
                        : TextStyle(color: AppColors.transparent),
                    validator: (value) {
                      setState(() => isNameError = true);

                      if (value == null || value.isEmpty) {
                        return 'signUpName.requiredName'.tr();
                      }
                      if (value.length < 2) {
                        return 'signUpName.invalidName'.tr();
                      }

                      setState(() => isNameError = false);
                      return null;
                    },
                  ),

                  if (showPassword) ...[
                    const Gap(26),
                    AppTextField(
                      hintText: '******',
                      label: 'Password',
                      labelSpace: 3,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      borderColor: AppColors.grey,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password should be 6 or more characters.';
                        }
                        return null;
                      },
                    ),
                    const Gap(12),
                    AppTextField(
                      hintText: '******',
                      label: 'Confirm Password',
                      labelSpace: 3,
                      controller: password2Controller,
                      keyboardType: TextInputType.text,
                      borderColor: AppColors.grey,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value != passwordController.text) {
                          return 'Password do no match';
                        }

                        return null;
                      },
                    ),
                  ],

                  ///
                  Spacer(),
                  if ((authNotifier.errorMsg ?? '').isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.red,
                          width: .5,
                        ),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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

                  Row(
                    children: [
                      Spacer(),
                      AppButton(
                        isDisabled: nameController.text.isEmpty,
                        title:
                            showPassword ? 'signUpName.signup' : 'shared.next',
                        translateText: true,
                        isLoading: authNotifier.isLoading,
                        isGradient: true,
                        width: 100,
                        onTap: () async {
                          if (!formKey.currentState!.validate()) return;
                          if (!showPassword) {
                            setState(() => showPassword = true);
                            return;
                          }

                          final map = {
                            'UserName': nameController.text,
                            'Password': passwordController.text,
                            'MobileNo': widget.phoneNumber,
                            'OTP': widget.otpCode,
                          };

                          bool? resp = await authNotifier.signUp(map: map);
                          if (resp == true && context.mounted) {
                            context.pop();
                          }

                          // context.pushReplacementNamed(RouteConsts.index);
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
      ),
    );
  }
}
