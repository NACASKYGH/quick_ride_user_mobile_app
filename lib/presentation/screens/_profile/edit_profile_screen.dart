import 'dart:io';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/app_colors.dart';
import '../../widget/image_loader.dart';
import 'package:go_router/go_router.dart';
import '../../widget/app_text_field.dart';
import '/presentation/widget/app_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = HLImagePicker();
  HLPickerItem? _selectedImage;
  String? gender;

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
                Row(),
                const Gap(16),

                /// User Profile Image
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      width: 110,
                      child: ImageLoader(
                        isFile: _selectedImage != null,
                        fileImage: _selectedImage != null
                            ? File(_selectedImage!.path)
                            : null,
                        imageUrl: emptyAssetImage,
                        isAsset: true,
                        height: 110,
                        radius: 110,
                        errorWidget: RandomAvatar('saytoonz'),
                      ),
                    ),
                    Material(
                      color: AppColors.whiteText,
                      borderRadius: BorderRadius.circular(24),
                      child: InkWell(
                        onTap: () async {
                          final images = await _picker.openPicker(
                            cropping: true,
                            pickerOptions: const HLPickerOptions(
                              mediaType: MediaType.image,
                              numberOfColumn: 4,
                              maxSelectedAssets: 1,
                              minSelectedAssets: 1,
                              convertHeicToJPG: true,
                              compressFormat: CompressFormat.jpg,
                              compressQuality: .5,
                            ),
                            cropOptions: const HLCropOptions(
                              aspectRatio:
                                  CropAspectRatio(ratioX: 1, ratioY: 1),
                            ),
                          );
                          setState(() {
                            _selectedImage = images.last;
                          });
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.grey,
                            ),
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

                ///
                const Gap(32),
                AppTextField(
                  label: 'profile.name'.tr(),
                  hintText: 'signUpName.title'.tr(),
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  borderColor: context.colors.tertiary,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'signUpName.requiredName'.tr();
                    }
                    if (value.length < 2) {
                      return 'signUpName.invalidName'.tr();
                    }
                    return null;
                  },
                ),
                const Gap(32),
                AppTextField(
                  initialValue: '020202020202',
                  disabled: true,
                  label: 'profile.phoneNumber'.tr(),
                  hintText: 'phoneNumber.title'.tr(),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  borderColor: context.colors.tertiary,
                  onChanged: (_) => setState(() {}),
                  suffixWidget: Icon(
                    Icons.done,
                    color: context.colors.primary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'phoneNumber.requiredName'.tr();
                    }
                    if (value.length < 2) {
                      return 'phoneNumber.invalidName'.tr();
                    }
                    return null;
                  },
                ),
                const Gap(16),
                const Spacer(),
                AppButton(
                  isDisabled: _fullNameController.text.isEmpty ||
                      _phoneController.text.isEmpty,
                  title: 'profile.updateProfile',
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
