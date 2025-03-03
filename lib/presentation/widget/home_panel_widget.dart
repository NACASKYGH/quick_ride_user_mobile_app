import 'package:gap/gap.dart';
import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/widget/app_button.dart';
import 'package:x_ride_user/presentation/widget/app_text_field.dart';
import 'package:x_ride_user/presentation/widget/circular_icon_btn.dart';

class HomePanelWidget extends StatelessWidget {
  const HomePanelWidget({
    super.key,
    required this.scrollController,
    required this.dragPosition,
    this.onWhereToTapped,
  });

  final double dragPosition;
  final ScrollController scrollController;
  final Function()? onWhereToTapped;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (dragPosition < 1)
          Opacity(
            opacity: 1 - dragPosition,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children: [
                  const Gap(12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 48,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withValues(alpha: .6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(12.0),
                  Text(
                    'home.greetings'.tr(args: ['Saytoonz']),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const Gap(6.0),
                  GestureDetector(
                    child: Row(
                      children: [
                        Expanded(
                          child: IgnorePointer(
                            ignoring: false,
                            child: AppTextField(
                              prefixWidget: Icon(Icons.search_rounded),
                              bgColor: AppColors.grey1.withValues(alpha: .1),
                              borderColor: AppColors.transparent,
                              hintText: 'home.whereTo'.tr(),
                              hintStyle:
                                  context.textTheme.headlineMedium?.copyWith(),
                              onTap: onWhereToTapped,
                            ),
                          ),
                        ),
                        const Gap(8),
                        AppButton(
                          width: 46,
                          height: 46,
                          radius: 8,
                          leading: Icon(
                            Icons.schedule_rounded,
                            color: AppColors.whiteText,
                          ),
                          title: '',
                          translateText: false,
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  const Gap(14),
                  Wrap(
                    children: [
                      ...[
                        'Town Park',
                        'Everyday Market',
                        'Old Station',
                        'Atta Mills',
                        'Old Barrier',
                        'Round About',
                        'Court',
                      ].map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Material(
                            color: context.colors.tertiary,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  e,
                                  style: context.textTheme.labelSmall?.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        if (dragPosition > 0)
          Opacity(
            opacity: dragPosition * dragPosition,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                controller: scrollController,
                children: [
                  const Gap(12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 48,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withValues(alpha: .6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(140),

                  ///
                  ...List.generate(
                    9,
                    (_) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircularIconBtn(
                              icon: Icon(Icons.history),
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
                            onTap: () {},
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
      ],
    );
  }
}
