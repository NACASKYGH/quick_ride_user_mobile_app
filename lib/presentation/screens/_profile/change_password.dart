import 'package:gap/gap.dart';
import '../../widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/app_text_field.dart';
import '../../../../utils/app_colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:quick_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:quick_ride_user/presentation/widget/base_screen.dart';
import 'package:quick_ride_user/presentation/notifiers/auth_notifier.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          'settings.changePass'.tr(),
        ),
      ),
      body: BaseScreen(
        safeArea: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(32),
                  AppTextField(
                    hintText: 'settings.oldPassword'.tr(),
                    obscureText: true,
                    controller: _oldPasswordController,
                    keyboardType: TextInputType.text,
                    borderColor: AppColors.grey.withValues(alpha: .7),
                    textColor: context.colors.primary,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'settings.fieldIsRequired'.tr();
                      }
                      if (value.length < 2) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  AppTextField(
                    hintText: 'settings.newPassword'.tr(),
                    controller: _newPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    borderColor: AppColors.grey.withValues(alpha: .7),
                    textColor: context.colors.primary,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'settings.fieldIsRequired'.tr();
                      }
                      if (value.length < 2) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  AppTextField(
                    hintText: 'settings.repeatPassword'.tr(),
                    controller: _repeatPasswordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    borderColor: AppColors.grey.withValues(alpha: .7),
                    textColor: context.colors.primary,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Password do no match';
                      }

                      return null;
                    },
                  ),
                  const Gap(42),
                  AppButton(
                    title: 'Update Password',
                    isGradient: true,
                    isLoading: isLoading,
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) return;
                      setState(() => isLoading = true);

                      try {
                        bool resp = await authNotifier.updatePassword(
                          oldPass: _oldPasswordController.text,
                          newPass: _newPasswordController.text,
                        );
                        if (resp) {
                          toast('Password has been updated successfully');
                        }
                      } catch (e) {
                        toast(e.toString());
                      }
                      setState(() => isLoading = false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
