import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PageLoader extends StatelessWidget {
  const PageLoader({
    super.key,
    this.title = 'Loading...',
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SpinKitChasingDots(
            color: AppColors.primary,
            size: 24,
          ),
          const Gap(6),
          Text(
            title,
            style: context.textTheme.labelSmall,
          ),
          const Gap(52)
        ],
      ),
    );
  }
}
