import '../../../di.dart';
import '../../../routes.dart';
import '/utils/extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../entity/osm_entity.dart';
import 'package:go_router/go_router.dart';
import '../../widget/app_text_field.dart';
import '../../widget/circular_icon_btn.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          widget.title,
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
            child: AppTextField(
              prefixWidget: Icon(Icons.search_rounded, size: 24),
              bgColor: AppColors.grey1.withValues(alpha: .1),
              borderColor: AppColors.transparent,
              focusBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.colors.primary),
              ),
              suffixWidget: GestureDetector(
                onTap: () async {
                  PickedData? firstDropOff =
                      await context.pushNamed(RouteConsts.pickLocation);
                  logger.d(firstDropOff?.toJson());
                },
                child: Container(
                  height: 14,
                  width: 14,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/map-svgrepo-com.svg',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    9,
                    (_) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircularIconBtn(
                              icon: Icon(Icons.location_pin),
                              bgColor: context.colors.tertiary,
                            ),
                            title: Text(
                              'Chicken man',
                              style: context.textTheme.headlineSmall?.copyWith(
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
                            onTap: () => context.pop(),
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
          )
        ],
      ),
    );
  }
}
