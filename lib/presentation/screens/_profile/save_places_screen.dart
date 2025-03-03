import '../../../routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widget/circular_icon_btn.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';

class SavePlacesScreen extends StatefulWidget {
  const SavePlacesScreen({
    super.key,
  });

  @override
  State<SavePlacesScreen> createState() => _SavePlacesScreenState();
}

class _SavePlacesScreenState extends State<SavePlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'profile.savedPlaces'.tr(),
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      3,
                      (_) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircularIconBtn(
                                icon: Icon(Icons.bookmark),
                                bgColor: context.colors.tertiary,
                              ),
                              title: Text(
                                'Chicken man',
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                'Father Patrick Lynch Street, Low Cost Estate, '
                                'Goaso, Asunafo North Municipal District, Ahafo '
                                'Region, BU-0003-8544, Ghana',
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall,
                              ),
                              onTap: () {
                                /// Delete location
                                /// Maybe edit
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
                title: 'profile.addNewPlace',
                radius: 8,
                onTap: () async {
                  await context.pushNamed(
                    RouteConsts.addLocation,
                    extra: 'profile.saveAPlace'.tr(),
                  );
                  if (context.mounted) {
                    context.pushNamed(RouteConsts.savePlaceAddName);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
