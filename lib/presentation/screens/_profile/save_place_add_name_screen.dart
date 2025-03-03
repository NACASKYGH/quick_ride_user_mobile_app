import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widget/app_text_field.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';

class SavePlaceAddNameScreen extends StatefulWidget {
  const SavePlaceAddNameScreen({super.key});

  @override
  State<SavePlaceAddNameScreen> createState() => _SavePlaceAddNameScreenState();
}

class _SavePlaceAddNameScreenState extends State<SavePlaceAddNameScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'profile.editProfile'.tr(),
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const Gap(32),
                AppTextField(
                  label: 'profile.nameOfPlace'.tr(),
                  hintText: 'profile.nameOfPlaceEg'.tr(),
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  borderColor: context.colors.tertiary,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'profile.requiredName'.tr();
                    }
                    return null;
                  },
                ),
                const Gap(32),
                AppTextField(
                  initialValue: 'Father Patrick Lynch Street, Low Cost Estate, '
                      'Goaso, Asunafo North Municipal District, Ahafo '
                      'Region, BU-0003-8544, Ghana',

                  ///
                  label: 'profile.address'.tr(),
                  hintText: 'profile.address'.tr(),
                  controller: _phoneController,
                  keyboardType: TextInputType.text,
                  borderColor: context.colors.tertiary,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                const Spacer(),
                AppButton(
                  isDisabled: _fullNameController.text.isEmpty ||
                      _phoneController.text.isEmpty,
                  title: 'profile.saveAddress',
                  radius: 8,
                  onTap: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.pop();
                  },
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
