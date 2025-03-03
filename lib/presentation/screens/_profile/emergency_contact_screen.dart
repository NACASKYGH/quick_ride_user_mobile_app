import '/di.dart';
import '/routes.dart';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import '../../widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'profile.emergencyContacts'.tr(),
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    const Gap(24),
                    Text(
                      'profile.emergencyContactsDesc'.tr(),
                      style: context.textTheme.labelMedium,
                    ),
                    const Gap(24),
                    ...List.generate(
                      3,
                      (_) {
                        return Column(
                          children: [
                            ListTile(
                              leading: RandomAvatar(
                                'saytoonz',
                                width: 60,
                                height: 60,
                              ),
                              title: Text(
                                'Alex Dickson',
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                '0208 457 888',
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                              onTap: () {
                                context.pushNamed(
                                  RouteConsts.emergencyContactsManager,
                                );
                              },
                            ),
                            Divider(
                              height: 12,
                              color: context.colors.tertiary,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppButton(
                title: 'profile.addContact',
                radius: 8,
                onTap: () async {
                  Contact? contact = await _contactPicker.selectPhoneNumber();
                  logger.d(contact?.phoneNumbers);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
