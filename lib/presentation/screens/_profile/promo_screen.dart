import '/utils/app_colors.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({
    super.key,
  });

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'profile.promos'.tr(),
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                3,
                (_) {
                  return Column(
                    children: [
                      ListTile(
                        isThreeLine: true,
                        leading: Icon(
                          Icons.sell,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          'Get 100% off up to GHS 20.00 on you visit to vaccination center',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          '\nCode: MEV70KE0 | Expires on 2nd May, 2025',
                          style: context.textTheme.labelSmall,
                        ),
                        onTap: () {
                          /// Delete location
                          /// Maybe edit
                        },
                      ),
                      Divider(
                        height: 18,
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
    );
  }
}
